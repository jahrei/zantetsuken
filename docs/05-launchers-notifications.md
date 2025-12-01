# Application Launchers and Notifications

**Primary Launcher**: Rofi
**Secondary Launcher**: Wofi
**Notification System**: HyprPanel

---

## Rofi - Primary Application Launcher

**Configuration Path**: `~/.config/rofi/`

### Configuration

**File**: `config.rasi`

```rasi
configuration {
    modes: "drun,run";
    display-drun: "";
    display-run: "";
    show-icons: true;
    icon-theme: "Papirus-Dark";
    matching: "fuzzy";
    case-sensitive: false;
    terminal: "kitty";
    sort: true;
    sorting-method: "fzf";
    disable-history: false;
    click-to-exit: true;
}
```

### Theme

**File**: `purple-sidebar.rasi`

- Material You purple color scheme
- Sidebar position (left edge)
- 480px width, 100% height
- Blur and dim effects via Hyprland layer rules

### Keybinding

```conf
bind = $mainMod, D, exec, rofi -show drun
```

---

## Wofi - Secondary Launcher (Wayland Native)

**Configuration Path**: `~/.config/wofi/`

### Configuration

**File**: `config`

```ini
width=480
height=100%
location=left
layer=overlay
show=drun,run
matching=fuzzy
insensitive=true
filter_rate=50
allow_images=true
image_size=32
term=kitty
```

### Theme

**File**: `style.css`

- Glassmorphic design
- 30px backdrop blur
- Staggered entry animations
- Purple accents

### Features

- Native Wayland support
- Advanced fuzzy matching
- Multi-action desktop entries
- Smart caching and history
- Vim keybinding support

---

## Custom Launcher Scripts

### Script Menu

**File**: `~/.config/hypr/scripts/script-menu.sh`

**Keybinding**: `Super + X`

**Features:**
- Save current workspace layout
- Load saved layouts
- Screenshot modes (area, save, OCR)
- Dynamic layout discovery

### Window Switcher

**File**: `~/.config/hypr/scripts/window-switcher.sh`

**Keybinding**: `Super + Tab`

**Features:**
- Shows all windows with titles
- Workspace and class information
- Fuzzy search via rofi
- Jump directly to any window

---

## HyprPanel - Notification System

**Configuration Path**: `~/.config/hyprpanel/`

### Notification Settings

```json
{
    "notifications": {
        "icon_size": 24,
        "notification_icon_size": 48,
        "default_timeout": "7s",
        "position": "POSITION_TOP_RIGHT",
        "margin": 24
    }
}
```

**Features:**
- Position: Top-right corner
- Auto-dismiss: 7 seconds
- DBus notification support
- Material You styling

### Associated Modules

| Module | Purpose |
|--------|---------|
| HUD | Volume/brightness feedback (2s timeout) |
| Systray | System tray icons |
| Power | Battery status |

---

## Screenshot Integration

**File**: `~/.config/hypr/scripts/screenshot.sh`

### Modes

| Mode | Keybind | Action |
|------|---------|--------|
| clipboard | Ctrl+Home | Screenshot to clipboard |
| save | Ctrl+Shift+Home | Save file + copy to clipboard |
| ocr | Ctrl+Alt+Home | Extract text via Tesseract |

### Dependencies

- `grim` - Screenshot capture
- `slurp` - Area selection
- `wl-copy` - Clipboard utility
- `tesseract` - OCR (optional)

### Notification Flow

```
Screenshot captured
       ↓
wl-copy stores in clipboard
       ↓
notify-send shows confirmation
       ↓
HyprPanel displays notification (7s)
```

---

## Clipboard Management

### Current Solution

Uses Wayland native utilities:
- `wl-copy` - Copy to clipboard
- `wl-paste` - Paste from clipboard

### Usage in Scripts

```bash
# Copy screenshot to clipboard
grim -g "$(slurp)" - | wl-copy

# Copy file to clipboard
wl-copy < file.png
```

---

## Keybindings Summary

| Keybind | Action | Tool |
|---------|--------|------|
| Super+D | Open app launcher | Rofi |
| Super+X | Open script menu | Custom rofi script |
| Super+Tab | Window switcher | Custom rofi script |
| Ctrl+Home | Screenshot to clipboard | grim/slurp |
| Ctrl+Shift+Home | Screenshot save + copy | grim/slurp |
| Ctrl+Alt+Home | Screenshot with OCR | grim/tesseract |

---

## Launcher Comparison

| Feature | Rofi | Wofi |
|---------|------|------|
| Fuzzy Matching | Yes (fzf) | Yes |
| Wayland Native | Partial | Full |
| Icon Support | Yes | Yes |
| Multi-Action | Limited | Yes |
| Animations | Basic | Advanced |
| History | Yes | Yes |

---

## Layer Rules (Hyprland)

```conf
layerrule = blur, rofi
layerrule = dimaround, rofi
layerrule = ignorezero, rofi
```

These apply blur effect and dim background when rofi is open.
