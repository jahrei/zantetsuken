# galaxias-ii

Hyprland rice for my main desktop (galaxias-ii).

## Overview

A modern Wayland-based desktop setup featuring:
- **Hyprland** with hy3 plugin for i3-like tiling
- **Material You** theming via Matugen
- **Multi-monitor** support (2x 1440p + 1x 1080p)

## Structure

```
galaxias-ii/
├── dots/              # ~/.config symlinks
│   ├── hypr/          # Hyprland + scripts + layouts
│   ├── waybar/        # Status bar
│   ├── kitty/         # Terminal
│   ├── rofi/          # App launcher
│   ├── wofi/          # Alt launcher
│   ├── matugen/       # Theme generator
│   ├── hyprpanel/     # Panel
│   ├── btop/          # System monitor
│   ├── fontconfig/    # Fonts
│   └── macchina/      # System info
├── home/              # ~/ dotfiles (.bashrc, etc)
├── scripts/           # Install/setup scripts
└── docs/              # Configuration documentation
```

## Installation

```bash
git clone https://github.com/jahrei/galaxias-ii.git ~/Documents/Projects/galaxias-ii
cd ~/Documents/Projects/galaxias-ii
./scripts/install.sh
```

This symlinks `dots/*` to `~/.config/` and `home/.*` to `~/`.

## Documentation

See [docs/](docs/) for detailed configuration documentation:
- [Hyprland](docs/01-hyprland.md) - WM config, keybindings, layouts
- [Waybar](docs/02-waybar.md) - Status bar
- [Terminal/Shell](docs/03-terminal-shell.md) - Fish, Kitty
- [Theming](docs/04-theming.md) - Material You, Matugen
- [Launchers](docs/05-launchers-notifications.md) - Rofi, notifications
- [Additional](docs/06-additional-components.md) - Audio, RGB, etc.

## Quick Reference

| Key | Action |
|-----|--------|
| Super + Return | Terminal |
| Super + D | App launcher |
| Super + Q | Close window |
| Super + 1-9 | Workspaces |
| Super + H/J/K/L | Navigate |

## Theming

Apply a new theme from any wallpaper:
```bash
matugen image /path/to/wallpaper.png
```

## Related

- [universal-rice](https://github.com/jahrei/universal-rice) - Shared rice documentation
