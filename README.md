# dotfiles

## Layout

- `common/` – cross-platform configs
- `dev/` - dev setup scripts
- `hw/` – hardware resources: vial-lily58pro (keyboard layouts)
- `windows/` – Windows-only
- `mac/` – macOS-only
- `linux/` – Linux-only (Omarchy): bash, display-tui, hypr, systemd, tmux, walker, waybar

## Stow (macOS/Linux)

Each platform dir is a stow directory targeting `$HOME` (see the `.stowrc` in each).

## macOS new-machine setup

```sh
cd mac && ./setup.sh              # work machine
cd mac && ./setup.sh --personal   # personal machine (+ Brewfile.personal)
```

What it does:

1. Installs Homebrew (if missing), then `brew bundle --file=mac/Brewfile`
   (formulae, casks, `kovacsgellert/tap`, VS Code extensions).
   With `--personal`, also installs `mac/Brewfile.personal`
   (orbstack, tailscale-app, bitwarden, rustdesk, steam,
   bambu-studio, insta360-studio).
2. Stows mac packages: `kanata karabiner tmux zsh dock-shortcuts`,
   and common packages: `ghostty starship opencode git`.
3. Clones the LazyVim starter into `~/.config/nvim` via `install-nvim.sh`
   (nvim config is intentionally not vendored; re-run that script with
   `--force` to reset to upstream).
4. Copies (not symlinks) `~/Library` configs: Vorssaint preferences,
   kanata-gui settings (profiles re-autodetect on first launch).
5. Prints manual steps: Accessibility permissions, Tailscale/OrbStack sign-in.

kanata runs via kanata-gui (auto-detects `~/.config/kanata/kanata.kbd`).

Dropped: Aerospace and Rectangle configs were removed (native + Vorssaint
windowing only). kanata-tray was removed (superseded by kanata-gui).
Leftovers not managed: `~/.config/dock-numbers`,
`alt-tab` LaunchAgent plist, `~/.config/{linearmouse,raycast}`.

Manual stow (without Brewfile):

```sh
cd mac && stow kanata karabiner tmux zsh dock-shortcuts
cd common && stow ghostty starship opencode git
./mac/install-nvim.sh
```
