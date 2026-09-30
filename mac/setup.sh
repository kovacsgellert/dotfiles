#!/usr/bin/env bash
# macOS new-machine setup. Idempotent: safe to re-run.
# Usage: ./setup.sh [--personal]   (--personal also installs Brewfile.personal)
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAC_DIR="$DOTFILES_DIR/mac"
COMMON_DIR="$DOTFILES_DIR/common"

info() { printf "\033[0;32m==>\033[0m \033[1m%s\033[0m\n" "$*"; }
warn() { printf "\033[1;33mWarning:\033[0m %s\n" "$*"; }

[[ "$(uname)" == "Darwin" ]] || { echo "macOS only." >&2; exit 1; }

# --- 1. Homebrew ---
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

# --- 2. Brewfile (formulae, casks, taps, vscode extensions) ---
info "brew bundle..."
brew bundle --file="$MAC_DIR/Brewfile"
if [[ "${1:-}" == "--personal" ]]; then
  info "brew bundle (personal)..."
  brew bundle --file="$MAC_DIR/Brewfile.personal"
fi

# --- 3. Stow configs ---
info "Stowing configs..."
# mac packages (target $HOME via mac/.stowrc)
(
  cd "$MAC_DIR"
  # NOTE: vorssaint + kanata-gui live under ~/Library and are handled below
  # (symlinking Preferences plists is fragile: macOS may replace the symlink
  # on write). Stow the XDG-style packages only.
  stow --restow kanata karabiner tmux zsh dock-shortcuts
)
# common packages
(
  cd "$COMMON_DIR"
  stow --restow ghostty starship opencode git
)

# --- 3b. Neovim (LazyVim starter, cloned — not vendored) ---
info "Installing nvim config..."
"$MAC_DIR/install-nvim.sh"

# --- 4. Library configs that should be copied, not symlinked ---
# Vorssaint preferences (cfprefsd may clobber symlinks, so copy).
info "Installing Vorssaint preferences..."
mkdir -p "$HOME/Library/Preferences"
if [[ -f "$MAC_DIR/vorssaint/Library/Preferences/com.vorssaint.utils.plist" ]]; then
  cp "$MAC_DIR/vorssaint/Library/Preferences/com.vorssaint.utils.plist" \
     "$HOME/Library/Preferences/com.vorssaint.utils.plist"
fi
# kanata-gui settings (profiles auto-detect the kanata.kbd path; only settings are portable).
if [[ -f "$MAC_DIR/kanata-gui/Library/Application Support/kanata-gui/settings.json" ]]; then
  info "Installing kanata-gui settings..."
  mkdir -p "$HOME/Library/Application Support/kanata-gui"
  cp "$MAC_DIR/kanata-gui/Library/Application Support/kanata-gui/settings.json" \
     "$HOME/Library/Application Support/kanata-gui/settings.json"
fi

# --- 6. opencode plugins ---
if command -v opencode >/dev/null 2>&1; then
  info "Installing opencode plugins (npm)..."
  (cd "$HOME/.config/opencode" && npx --yes opencode install 2>/dev/null || true)
  # alternative if bun is preferred:
  # (cd "$HOME/.config/opencode" && bun install 2>/dev/null || true)
fi

# --- 6. kanata GUI ---
# kanata-gui auto-detects ~/.config/kanata/kanata.kbd. Launch it once and
# enable Start at Login + Input Monitoring when prompted.

# --- 8. Manual post-install reminders ---
cat <<'EOF'

Setup complete. Manual steps remaining:
  1. Accessibility: Karabiner-Elements, KanataGUI, DockShortcuts,
     Vorssaint (System Settings > Privacy & Security > Accessibility).
  2. Input Monitoring: kanata if prompted.
  3. Tailscale: sign in. OrbStack / Docker: launch once for VM setup.
  4. `code --list-extensions` should match Brewfile vscode entries
     (installed automatically by `brew bundle`).

Stale leftovers this setup does NOT manage (safe to delete by hand):
  ~/.config/dock-numbers  (renamed to dock-shortcuts)
  ~/Library/LaunchAgents/com.lwouis.alt-tab-macos.plist (alt-tab uninstalled)
  ~/.config/linearmouse ~/.config/raycast (apps uninstalled)
EOF
