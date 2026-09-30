#!/usr/bin/env bash
# Installs the LazyVim starter config (https://github.com/LazyVim/starter).
# The nvim config is intentionally NOT vendored in dotfiles: it is cloned
# from upstream so it can be updated independently (`git pull` won't work
# here since .git is removed; re-run with --force to reset to upstream).
# Idempotent: safe to re-run.
set -euo pipefail

FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

TARGET="${NVIM_CONFIG_DIR:-$HOME/.config/nvim}"
REPO="https://github.com/LazyVim/starter"

if [[ -d "$TARGET" && -n "$(ls -A "$TARGET" 2>/dev/null)" ]]; then
  if [[ "$FORCE" == true ]]; then
    echo "Removing existing $TARGET (--force)..."
    rm -rf "$TARGET"
  else
    echo "nvim config already exists at $TARGET, skipping (use --force to reset)."
    exit 0
  fi
fi

echo "Cloning LazyVim starter into $TARGET..."
mkdir -p "$(dirname "$TARGET")"
git clone --depth 1 "$REPO" "$TARGET"
rm -rf "$TARGET/.git"
echo "Done. Launch 'nvim' once to install plugins (requires network)."
