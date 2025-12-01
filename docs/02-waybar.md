# Waybar Configuration Documentation

**Configuration Path**: `~/.config/waybar/`

## Overview

Waybar provides a top-aligned status bar for the Hyprland window manager. The setup uses Material You theming with a dark color palette.

---

## Bar Layout and Positioning

**File:** `~/.config/waybar/config.jsonc`

### Bar Properties

| Property | Value | Description |
|----------|-------|-------------|
| layer | `top` | Bar renders on the top layer |
| position | `top` | Bar positioned at top of screen |
| mod | `dock` | Bar behaves as a dock |
| exclusive | `true` | Windows don't overlap the bar |
| gtk-layer-shell | `true` | Uses GTK layer shell protocol |
| height | `0` | Auto-calculated based on content |

### Module Layout

```
[Left]              [Center]           [Right]
hyprland/workspaces  hyprland/window   pulseaudio, mpris, clock, tray
```

---

## Module Configurations

### Hyprland Workspaces

```jsonc
"hyprland/workspaces": {
    "disable-scroll": true,
    "all-outputs": false,
    "on-click": "activate"
}
```

### Hyprland Window

```jsonc
"hyprland/window": {
    "format": "{}"
}
```

Shows the title of the currently active window.

### PulseAudio

```jsonc
"pulseaudio": {
    "format": "{icon} {volume}%",
    "format-muted": "Muted ",
    "on-click": "pamixer -t",
    "on-scroll-up": "pamixer -i 5",
    "on-scroll-down": "pamixer -d 5",
    "scroll-step": 5,
    "format-icons": {
        "headphone": "",
        "default": ["", "", ""]
    }
}
```

**Features:**
- Volume percentage display
- Different icons for output devices
- Mouse wheel volume control
- Click to toggle mute

### MPRIS (Media Player)

```jsonc
"mpris": {
    "format": "{status_icon} {length}",
    "format-paused": "{status_icon} <i>{position}/{length}</i>",
    "status-icons": {
        "playing": "▶",
        "paused": ""
    }
}
```

### Clock

```jsonc
"clock": {
    "format": " {:%d %b   %I:%M %p}",
    "tooltip-format": "<big>{:%Y}</big>\n<tt><small>{calendar}</small></tt>"
}
```

**Display:** `01 Dec   12:30 PM`

### System Tray

```jsonc
"tray": {
    "spacing": 10
}
```

---

## Theme and Styling

**File:** `~/.config/waybar/style.css`

### Color Palette

| Color | Hex Value | Usage |
|-------|-----------|-------|
| base | `#111318` | Primary background |
| surface1 | `#191c20` | Tertiary background |
| text | `#e2e2e9` | Primary text |
| mauve | `#abc7ff` | Accent (active, hover) |
| green | `#ddbce0` | Focused state |
| red | `#ffb4ab` | Urgent state |

### Global Styling

```css
* {
    font-family: JetBrainsMono Nerd Font Mono, monospace;
    font-weight: bold;
    font-size: 14px;
}
```

### Workspace Button States

| State | Style |
|-------|-------|
| Normal | Dim gray text, no background |
| Active | Mauve (light blue) text |
| Focused | Text on green background, rounded |
| Urgent | Light text on red background |
| Hover | Dark text on mauve background |

---

## Dependencies

| Tool | Purpose |
|------|---------|
| pamixer | Volume control |
| Nerd Font | Icons |
| Hyprland | Workspace/window modules |
