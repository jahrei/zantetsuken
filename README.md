# galaxias-ii
electric boogaloo

A comprehensive Hyprland-based rice configuration managed with [chezmoi](https://www.chezmoi.io/).

## Overview

This repository contains my personal Linux rice (desktop customization) featuring a modern Wayland-based setup with Hyprland as the window manager. The configuration emphasizes aesthetics, functionality, and workflow efficiency.

## Screenshots

*Coming soon*

## Components

### Core Desktop Environment

- **Window Manager**: [Hyprland](https://hyprland.org/) - Dynamic tiling Wayland compositor
  - Custom layouts (default, dev, productivity, chinese)
  - Custom color scheme configuration
  - Hyprpaper for wallpaper management
  - Automation scripts for layout management and screenshots

- **Status Bars**:
  - [Waybar](https://github.com/Alexays/Waybar) - Highly customizable Wayland bar
  - [Hyprpanel](https://github.com/Jas-SinghFSU/HyprPanel) - Alternative Hyprland-specific panel

- **Terminal**: [Kitty](https://sw.kovidkat.net/kitty/) - GPU-accelerated terminal emulator
  - Custom color scheme
  - Optimized configuration

- **Application Launchers**:
  - [Rofi](https://github.com/davatorium/rofi) - Window switcher and app launcher (with purple-sidebar theme)
  - [Wofi](https://hg.sr.ht/~scoopta/wofi) - Native Wayland launcher alternative

### Theming & Customization

- **Matugen**: Material You color generation from wallpapers
  - Templates for Hyprland, Kitty, Waybar, and Hyprpanel
  - Automated theming workflow

- **Fontconfig**: Custom font configuration for consistent typography

### System Utilities

- **Btop**: Beautiful system resource monitor
- **Macchina**: Fast system information tool with custom ASCII art themes
- **htop**: Interactive process viewer

### Shell & Development

- **Bash**: Custom shell configuration
- **Git**: Version control configuration

## Installation

### Prerequisites

Ensure you have the following installed:
- [chezmoi](https://www.chezmoi.io/)
- [Hyprland](https://hyprland.org/)
- [Kitty](https://sw.kovidkat.net/kitty/)
- [Waybar](https://github.com/Alexays/Waybar)
- [Rofi](https://github.com/davatorium/rofi)
- [Wofi](https://hg.sr.ht/~scoopta/wofi)
- [Matugen](https://github.com/InioX/matugen)
- [Macchina](https://github.com/Macchina-CLI/macchina)
- [Btop](https://github.com/aristocratos/btop)

### Using Chezmoi (Recommended)

```bash
# Initialize chezmoi with this repository
chezmoi init https://github.com/jahrei/galaxias-ii.git

# Preview changes
chezmoi diff

# Apply the configuration
chezmoi apply
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/jahrei/galaxias-ii.git
cd galaxias-ii

# Copy dotfiles manually (adjust paths as needed)
# Note: chezmoi uses special prefixes like 'dot_' and 'private_dot_config'
# You'll need to rename files accordingly
```

## Repository Structure

This repository uses a dual structure for maximum compatibility:

### For Users (Open Source Structure)

```
galaxias-ii/
├── config/            # Application configurations
│   ├── hypr/         # Hyprland window manager
│   │   ├── hyprland.conf
│   │   ├── colors.conf
│   │   ├── layouts/
│   │   └── scripts/
│   ├── fish/         # Fish shell
│   ├── kitty/        # Kitty terminal
│   ├── waybar/       # Status bar
│   ├── hyprpanel/    # Alternative panel
│   ├── rofi/         # App launcher
│   ├── wofi/         # Alternative launcher
│   ├── matugen/      # Color generation
│   ├── macchina/     # System info
│   ├── btop/         # System monitor
│   └── fontconfig/   # Font config
├── home/             # Home directory dotfiles
│   ├── .bashrc
│   ├── .bash_profile
│   ├── .bash_logout
│   └── .gitconfig
└── README.md
```

### For Chezmoi Users

The `.chezmoi/` directory contains the original chezmoi-formatted files for direct use with chezmoi. This directory is gitignored to keep the public-facing structure clean.

**To use with chezmoi:**
```bash
# Clone directly to chezmoi source
chezmoi init https://github.com/jahrei/galaxias-ii.git

# Or manually
git clone https://github.com/jahrei/galaxias-ii.git
cd galaxias-ii/.chezmoi
chezmoi init
```

## Customization

### Changing Colors

This rice uses Matugen for color generation. To generate a new color scheme from a wallpaper:

```bash
matugen image /path/to/your/wallpaper.jpg
```

The generated colors will automatically update Hyprland, Kitty, Waybar, and Hyprpanel configurations.

### Custom Layouts

Hyprland layouts are stored in `~/.config/hypr/layouts/`. To save your current layout:

```bash
~/.config/hypr/scripts/load-layout.sh
```

To load a layout:

```bash
~/.config/hypr/scripts/save-layout.sh layout-name
```

### Modifying Configurations

When using chezmoi, always edit files through chezmoi to ensure changes are tracked:

```bash
# Edit a config file
chezmoi edit ~/.config/hypr/hyprland.conf

# Apply changes
chezmoi apply
```

## Scripts

Located in `~/.config/hypr/scripts/`:

- `load-layout.sh` - Load saved window layouts
- `save-layout.sh` - Save current window layout
- `screenshot.sh` - Screenshot utility
- `script-menu.sh` - Interactive script menu

## Contributing

Feel free to fork this repository and customize it for your own use. If you have improvements or suggestions, pull requests are welcome!

## License

This configuration is provided as-is for personal use. Feel free to use, modify, and share.

## Acknowledgments

- [Hyprland](https://hyprland.org/) community
- [r/unixporn](https://reddit.com/r/unixporn) for inspiration
- All the amazing open-source tool developers

---

**Note**: This is a personal configuration. Some settings may need adjustment based on your system, hardware, and preferences.
