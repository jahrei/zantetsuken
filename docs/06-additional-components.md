# Additional Rice Components

---

## Audio Management

### Volume Control

**Tools**: wpctl, pamixer, playerctl

**Keybindings:**
```conf
bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
```

**Waybar Integration:**
- Uses pamixer for volume display
- Scroll wheel adjusts volume
- Click toggles mute

### Media Control

**Tool**: playerctl

**Keybindings:**
```conf
bindl = , XF86AudioNext, exec, playerctl next
bindl = , XF86AudioPrev, exec, playerctl previous
bindl = , XF86AudioPlay, exec, playerctl play-pause
bindl = , XF86AudioPause, exec, playerctl play-pause
```

**Waybar MPRIS Module:**
- Shows playing/paused status
- Displays track duration
- Supports multiple players

---

## RGB LED Control

### Hardware

- Asiahorse Venom case fans
- Controlled via OpenRGB

### Control Script

**File**: `~/.config/hypr/scripts/rgb-control.sh`

**Usage:**
```bash
rgb-control.sh [mode]
```

**Available Modes:**

| Mode | Color | Effect |
|------|-------|--------|
| blue | #0000FF | Solid |
| cyan | #7DD3FC | Solid |
| red | #FF0000 | Solid |
| green | #00FF00 | Solid |
| purple | #9B59B6 | Solid |
| white | #FFFFFF | Solid |
| rainbow | - | Spectrum cycle |
| breathing | #0000FF | Pulsing |
| theme | - | Sync with Hyprland |
| off | - | Turn off |

### Theme Sync

**File**: `~/.config/hypr/scripts/rgb-theme-sync.sh`

Extracts primary color from `~/.config/hypr/colors.conf` and applies to LEDs.

```bash
# Called by rgb-control.sh theme
openrgb --device 1 --zone 0 --mode direct --color $primary
```

### Scheduling

**File**: `~/.config/hypr/scripts/rgb-schedule.sh`

- Night mode (21:00-06:00): LEDs off
- Day mode (06:00-21:00): Purple

Can be run via cron:
```bash
0 * * * * ~/.config/hypr/scripts/rgb-schedule.sh
```

---

## File Manager

### Dolphin

**Default file manager**: Dolphin (KDE)

**Configuration**: `~/.config/kdeglobals`
```ini
[General]
TerminalApplication=kitty
```

**Keybinding:**
```conf
bind = $mainMod, E, exec, dolphin
```

---

## Screen Locking & Idle

### Status

Currently **not configured**. Easy to add:

**hyprlock** (screen locker):
```bash
sudo pacman -S hyprlock
```

**hypridle** (idle daemon):
```bash
sudo pacman -S hypridle
```

### Example hypridle.conf

```conf
general {
    lock_cmd = hyprlock
    before_sleep_cmd = hyprlock
}

listener {
    timeout = 300
    on-timeout = hyprlock
}

listener {
    timeout = 600
    on-timeout = hyprctl dispatch dpms off
    on-resume = hyprctl dispatch dpms on
}
```

---

## System Services

### Autostart Services

```conf
exec-once = systemctl --user start hyprpolkitagent
exec-once = swww-daemon
exec-once = waybar
exec-once = hyprpm reload -n && hyprctl reload
```

### PolicyKit Agent

**hyprpolkitagent**: Handles authentication dialogs for sudo/admin actions in GUI applications.

---

## Portal Integration

### XDG Desktop Portal

**Permission:**
```conf
permission = /usr/libexec/xdg-desktop-portal-hyprland, screencopy, allow
```

Enables:
- Screen sharing
- File picker dialogs
- Screenshot permissions

---

## Hyprland Ecosystem Tools

### Installed

| Tool | Purpose |
|------|---------|
| hyprctl | Hyprland control utility |
| hyprpm | Plugin manager |
| hyprpaper | Static wallpaper daemon |

### Available (Not Installed)

| Tool | Purpose |
|------|---------|
| hyprlock | Screen locker |
| hypridle | Idle daemon |
| hyprpicker | Color picker |

---

## Network Management

### Status

Network Manager UI is available but commented out in config.

**To enable:**
```conf
exec-once = nm-applet --indicator
```

---

## Bluetooth

### Status

Not currently configured.

**To add:**
```bash
sudo pacman -S blueman
```

Then add to autostart:
```conf
exec-once = blueman-applet
```

---

## System Tray

### Waybar Tray

```jsonc
"tray": {
    "spacing": 10
}
```

Shows system tray icons from running applications.

### HyprPanel Systray

- Auto-hide after 4 seconds
- Material You styling

---

## Brightness Control

### Keybindings

```conf
bindel = , XF86MonBrightnessUp, exec, brightnessctl s 5%+
bindel = , XF86MonBrightnessDown, exec, brightnessctl s 5%-
```

### HyprPanel HUD

Displays brightness level feedback:
- Position: Bottom
- Timeout: 2 seconds

---

## Package Management

### Pacman Hook for Hyprpm

**File**: `/etc/pacman.d/hooks/hyprpm.hook`

```ini
[Trigger]
Operation = Install
Operation = Upgrade
Type = Package
Target = hyprland

[Action]
Description = Rebuilding Hyprland plugins...
When = PostTransaction
Exec = /usr/bin/hyprpm update -f
```

Automatically rebuilds hy3 plugin when Hyprland updates.

---

## Quick Reference

### Essential Commands

```bash
# Reload Hyprland config
hyprctl reload

# List plugins
hyprpm list

# Rebuild plugins
hyprpm update -f

# Apply new theme
matugen image /path/to/wallpaper.png

# Control RGB
~/.config/hypr/scripts/rgb-control.sh theme

# Check Hyprland info
hyprctl info

# List windows
hyprctl clients
```

### Important Paths

| Path | Purpose |
|------|---------|
| ~/.config/hypr/ | Hyprland config |
| ~/.config/waybar/ | Waybar config |
| ~/.config/kitty/ | Kitty terminal |
| ~/.config/fish/ | Fish shell |
| ~/.config/rofi/ | Rofi launcher |
| ~/.config/matugen/ | Theme generator |
| /etc/pacman.d/hooks/ | Pacman hooks |
