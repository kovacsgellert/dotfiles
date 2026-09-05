#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"
fi

brew install --formula \
  bat \
  btop \
  docker \
  eza \
  fd \
  ffmpeg \
  fzf \
  gh \
  git \
  jq \
  kanata \
  kanata-tray \
  lazygit \
  neovim \
  opencode \
  python@3.14 \
  starship \
  stow \
  tmux \
  yazi \
  yq \
  zoxide

brew install --cask \
  alt-tab \
  bruno \
  font-jetbrains-mono-nerd-font \
  ghostty \
  google-chrome \
  karabiner-elements \
  linearmouse \
  marta \
  opencode-desktop \
  raycast \
  rectangle \
  tailscale-app \
  visual-studio-code \
  zen

echo "All apps installed."