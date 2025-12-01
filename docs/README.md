# Rice Setup Documentation

**System**: EndeavourOS (Arch Linux)
**Window Manager**: Hyprland 0.52.1
**Theme**: Material You (Dark)
**Generated**: December 1, 2025

---

## Quick Overview

This is a comprehensive Hyprland desktop environment featuring:

- **Tiling**: hy3 plugin for i3-like window management
- **Theming**: Material You colors auto-generated from wallpaper via Matugen
- **Multi-Monitor**: 3 displays (2x 1440p + 1x 1080p)
- **Productivity**: Custom layouts, scripts, and keybindings
- **Hardware Integration**: RGB LED sync with theme colors

---

## Documentation Index

| File | Description |
|------|-------------|
| [01-hyprland.md](01-hyprland.md) | Window manager configuration, keybindings, layouts |
| [02-waybar.md](02-waybar.md) | Status bar modules and styling |
| [03-terminal-shell.md](03-terminal-shell.md) | Fish shell, Kitty terminal configuration |
| [04-theming.md](04-theming.md) | Material You theming, Matugen, colors |
| [05-launchers-notifications.md](05-launchers-notifications.md) | Rofi, Wofi, notifications |
| [06-additional-components.md](06-additional-components.md) | Audio, RGB, file manager, utilities |

---

## Key Keybindings

### Window Management
| Key | Action |
|-----|--------|
| Super + Return | Open terminal |
| Super + Q | Close window |
| Super + D | App launcher |
| Super + H/J/K/L | Navigate windows |
| Super + 1-9 | Switch workspace |

### Productivity
| Key | Action |
|-----|--------|
| Super + X | Script menu |
| Super + Tab | Window switcher |
| Super + / | Show keybinds |
| Ctrl + Home | Screenshot |

### Layouts (hy3)
| Key | Action |
|-----|--------|
| Super + V | Vertical split |
| Super + W | Tab group |
| Super + Ctrl + L | Load default layout |

---

## Configuration Paths

```
~/.config/
├── hypr/           # Hyprland, scripts, layouts
├── waybar/         # Status bar
├── kitty/          # Terminal
├── fish/           # Shell
├── rofi/           # Launcher
├── wofi/           # Alt launcher
├── matugen/        # Theme generator
└── hyprpanel/      # Panel/notifications
```

---

## Theme Application

Apply a new theme from any wallpaper:

```bash
matugen image /path/to/wallpaper.png
```

This updates colors across:
- Hyprland borders and decorations
- Waybar styling
- Kitty terminal colors
- HyprPanel
- Sets the wallpaper via swww

---

## Active Components

| Component | Tool |
|-----------|------|
| Window Manager | Hyprland + hy3 plugin |
| Status Bar | Waybar |
| Panel | HyprPanel |
| Terminal | Kitty |
| Shell | Fish |
| App Launcher | Rofi |
| Theme Generator | Matugen |
| Wallpaper | swww + hyprpaper |
| Screenshots | grim + slurp |
| Clipboard | wl-copy |
| File Manager | Dolphin |
| RGB Control | OpenRGB |

---

## Maintenance

### Plugin Rebuild (Automatic)

A pacman hook at `/etc/pacman.d/hooks/hyprpm.hook` automatically rebuilds hy3 when Hyprland updates.

### Manual Plugin Rebuild

```bash
hyprpm update -f
hyprpm reload
```

### Reload Configuration

```bash
hyprctl reload
```

---

## Statistics

- **Keybindings**: 60+
- **Custom Scripts**: 9
- **Saved Layouts**: 6
- **Color Variables**: 50+
- **Fish Abbreviations**: 60+

---

## Missing (Easy to Add)

| Component | Package | Purpose |
|-----------|---------|---------|
| Screen Lock | hyprlock | Lock screen |
| Idle Daemon | hypridle | Auto-lock/DPMS |
| Bluetooth | blueman | BT management |
| Network GUI | nm-applet | Network tray |
