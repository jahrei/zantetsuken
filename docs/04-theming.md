# Theming and Appearance Configuration

**Theme System**: Material You (via Matugen)
**Color Mode**: Dark theme with cool blue accents

---

## Overview

The system uses a sophisticated theming setup centered on **Material You** color scheme generation via **Matugen**, with comprehensive application support.

---

## Matugen - Dynamic Color Generation

**Configuration Path**: `~/.config/matugen/`

### Main Configuration (config.toml)

```toml
[config]
caching = true

[config.wallpaper]
set = true
command = "swww"
arguments = ["img", "--transition-type", "center"]

[templates.waybar]
input_path = "~/.config/matugen/templates/waybar.css"
output_path = "~/.config/waybar/style.css"
post_hook = "killall -SIGUSR2 waybar || true"

[templates.hyprland]
input_path = "~/.config/matugen/templates/hyprland-colors.conf"
output_path = "~/.config/hypr/colors.conf"
post_hook = "hyprctl reload"

[templates.kitty]
input_path = "~/.config/matugen/templates/kitty.conf"
output_path = "~/.config/kitty/colors.conf"
post_hook = "killall -SIGUSR1 kitty || true"
```

### Templates

Located in `~/.config/matugen/templates/`:

| Template | Output | Purpose |
|----------|--------|---------|
| waybar.css | ~/.config/waybar/style.css | Waybar styling |
| kitty.conf | ~/.config/kitty/colors.conf | Terminal colors |
| hyprland-colors.conf | ~/.config/hypr/colors.conf | WM colors |
| hyprpanel.css | HyprPanel styling | Panel colors |

### Applying a New Theme

```bash
matugen image /path/to/wallpaper.png
```

This command:
1. Analyzes the wallpaper image
2. Generates Material You color palette
3. Applies templates to all configured applications
4. Runs post-hooks to reload each application
5. Sets wallpaper via swww

---

## Color Palette

### Primary Colors

| Variable | Hex | Purpose |
|----------|-----|---------|
| Primary | #abc7ff | Active borders, accents |
| Secondary | #bec6dc | Secondary elements |
| Tertiary | #7dd3fc | Tertiary accents |
| Error | #ffb4ab | Error states |

### Surface Colors

| Variable | Hex | Purpose |
|----------|-----|---------|
| Surface | #111318 | Background |
| Surface Bright | #37393e | Elevated surfaces |
| Surface Dim | #111318 | Recessed surfaces |
| On Surface | #e2e2e9 | Text on surfaces |

### Convenience Aliases

```conf
$active_border = $primary        # #abc7ff
$inactive_border = $outline_variant  # #44474e
$background = $surface           # #111318
$foreground = $on_surface        # #e2e2e9
```

---

## Wallpaper Management

### Hyprpaper Configuration

**File**: `~/.config/hypr/hyprpaper.conf`

```conf
preload = /home/jahrei/Documents/Wallpapers/kairos_roughdraft_1.png

wallpaper = DP-1,/home/jahrei/Documents/Wallpapers/kairos_roughdraft_1.png
wallpaper = DP-2,/home/jahrei/Documents/Wallpapers/kairos_roughdraft_1.png
wallpaper = Unknown-2,/home/jahrei/Documents/Wallpapers/kairos_roughdraft_1.png
```

### Wallpaper Daemons

- **hyprpaper**: Static wallpaper configuration
- **swww**: Dynamic wallpaper with transitions (used by Matugen)

**Setting Wallpaper Manually:**
```bash
swww img /path/to/wallpaper.png --transition-type center
```

---

## Font Configuration

### Fontconfig

**File**: `~/.config/fontconfig/fonts.conf`

```xml
<fontconfig>
  <alias>
    <family>monospace</family>
    <prefer>
      <family>JetBrainsMono Nerd Font Mono</family>
      <family>JetBrains Mono</family>
    </prefer>
  </alias>
</fontconfig>
```

### Installed Fonts

**Location**: `~/.local/share/fonts/`

- **Iosevka** - Full font family (476 variants)
- **Supply** - Various weights
- **JetBrains Mono** - System-wide with Nerd Font

**Font Usage by Application:**

| Application | Font | Size |
|-------------|------|------|
| Kitty | Iosevka Term | 12pt |
| Waybar | JetBrainsMono Nerd Font Mono | 14px |
| Rofi | JetBrainsMono Nerd Font | varies |

---

## Cursor Configuration

```conf
env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24
```

- Cursor size: 24px
- Uses Hyprland native cursors (HYPRCURSOR)
- Fallback to X11 cursor (XCURSOR)

---

## Theming Workflow

```
Wallpaper Selection
        ↓
Matugen Color Extraction (Material You algorithm)
        ↓
Color Palette Generation (100+ color variables)
        ↓
Template Processing (Tera engine)
        ├─→ hyprland-colors.conf → hyprctl reload
        ├─→ waybar.css → killall -SIGUSR2 waybar
        ├─→ kitty.conf → killall -SIGUSR1 kitty
        └─→ hyprpanel.css
        ↓
swww img (sets wallpaper)
        ↓
Unified Visual Experience
```

---

## RGB LED Integration

### RGB Control Script

**File**: `~/.config/hypr/scripts/rgb-control.sh`

**Modes:**
| Mode | Effect |
|------|--------|
| blue | Solid #0000FF |
| cyan | Solid #7DD3FC |
| rainbow | Spectrum cycle |
| breathing | Blue breathing |
| theme | Sync with Hyprland theme |
| off | Turn off LEDs |

**Theme Sync:**
```bash
~/.config/hypr/scripts/rgb-theme-sync.sh
```
Extracts primary color from colors.conf and applies to OpenRGB.

### RGB Scheduling

**File**: `~/.config/hypr/scripts/rgb-schedule.sh`

- Night mode (21:00-06:00): LEDs off
- Day mode (06:00-21:00): Purple (#9B59B6)

---

## Application-Specific Theming

### Rofi

**Theme**: Material You Purple
- Sidebar position (left)
- 480px width, full height
- Blur and dim effects via Hyprland

### Wofi

**Theme**: Glassmorphic Oxide
- Same positioning as Rofi
- Enhanced animations
- Backdrop blur (30px)

### HyprPanel

**Position**: Right side
- Width: 64px
- Material You integration
- Notifications top-right

---

## Summary

| Component | Theme Source |
|-----------|--------------|
| Hyprland | colors.conf (Matugen) |
| Waybar | style.css (Matugen) |
| Kitty | colors.conf (Matugen) |
| Rofi | Material You purple |
| HyprPanel | Matugen template |
| RGB LEDs | Theme sync script |
