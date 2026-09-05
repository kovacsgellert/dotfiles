# dotfiles

## Layout

- `common/` – cross-platform configs
- `dev/` - dev setup scripts
- `hw/` – hardware resources: vial-lily58pro (keyboard layouts)
- `windows/` – Windows-only
- `mac/` – macOS-only
- `linux/` – Linux-only (Omarchy): bash, display-tui, hypr, systemd, tmux, walker, waybar

## Stow (macOS/Linux)

Each platform dir is a stow directory targeting `$HOME` (see the `.stowrc` in each). Run stow from inside the platform dir:

```sh
cd mac && stow kanata tmux aerospace zsh
cd common && stow ghostty starship
```
