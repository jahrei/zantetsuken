# Modernized Oxide-Inspired Wofi Configuration

## Overview
This configuration converts the classic rofi Oxide theme to wofi with modern enhancements including purple palette integration, glassmorphic effects, smooth animations, and comprehensive smart features.

## Features Implemented

### 🎨 Visual Design
- **Oxide Theme Base**: Preserved the clean, minimalist aesthetic of the original Oxide theme
- **Purple Palette**: Integrated your system's purple color scheme (#3B1A5A → #BB86FC gradient)
- **Glassmorphic Effects**: Semi-transparent backgrounds with backdrop blur (30px)
- **Alternating Rows**: Subtle striped background for better readability
- **Smooth Animations**: Progressive entry loading with staggered delays
- **Scrollbar Styling**: Custom purple scrollbar that matches the theme

### 🧠 Smart Features

#### 1. **Fuzzy Matching**
- Uses hybrid fuzzy/contains algorithm
- Smart prefix matching with Levenshtein distance
- Case-insensitive search enabled
- Automatically filters markup/images from search

#### 2. **Combi Mode**
- Searches both `drun` (applications) and `run` (executables) simultaneously
- Single unified interface for all launch needs
- History-based sorting for frequently used apps

#### 3. **Multi-Action Support**
- Desktop entries with multiple actions show expander widget
- Press `Right` arrow to expand/contract action menus
- Styled expander boxes with purple accents

#### 4. **Smart Caching**
- Maintains launch history in `~/.cache/wofi-drun` and `~/.cache/wofi-run`
- Most frequently used items appear first
- Learns your usage patterns over time

#### 5. **Image & Markup Support**
- Displays application icons (32px)
- Renders pango markup for rich text
- Icons animate on hover with rotation and glow effects

### ⌨️ Keyboard Navigation

#### Basic Navigation
- `↑/↓` - Navigate entries
- `Tab` - Next entry
- `Shift+Tab` - Previous entry
- `Enter` - Launch selected app
- `Escape` - Close launcher
- `Page Up/Down` - Jump by page

#### Advanced Keys
- `Right` - Expand multi-action entries
- `Ctrl+C` - Copy selection to clipboard
- `Ctrl+1/2/3` - Custom exit codes (for scripting)

### 🎭 State-Based Styling

#### Entry States
1. **Normal**: Transparent background, light gray text (#C4CAD4)
2. **Alternate**: Subtle dark background for even rows
3. **Hover**: Purple highlight with slide animation
4. **Selected**: Bright purple (#7B2CBF) with glow and scale effect
5. **Activatable**: Blue accent border for special entries

#### Interactive Effects
- **Hover**: Entry slides right 6px with purple shadow
- **Selected**: Entry slides right 8px, scales 1.01x, purple glow
- **Icons**: Scale and rotate on hover, glow filter when selected
- **Input Focus**: Purple glow animation around search box

### 🚀 Performance Optimizations
- 50ms filter rate for responsive search
- `will-change` hints for GPU acceleration
- Optimized transitions with cubic-bezier easing
- Progressive loading animation to reduce perceived latency

### 📐 Layout Details

#### Sidebar Configuration
- **Width**: 480px
- **Height**: 100% (full screen height)
- **Position**: Left edge of screen
- **Layer**: Overlay (appears above all windows)
- **Padding**: 20px internal spacing
- **Backdrop Blur**: 30px for glassmorphic effect

#### Typography
- **Font**: JetBrainsMono Nerd Font
- **Size**: 14px base, 13px for sub-entries
- **Weight**: 500 normal, 600 for selected items
- **Color**: Oxide gray (#C4CAD4) with white highlights

## Color Palette Reference

```css
/* From Oxide Original */
Background:     #212121 (dark gray)
Foreground:     #C4CAD4 (light gray)
Alt Background: #2A2A2A (darker gray)
Selected:       #5A5A5A (medium gray)
Bright Text:    #F9F9F9 (white)

/* Purple System Integration */
Deep Purple:    #3B1A5A (waybar workspaces)
Medium Purple:  #5A189A (waybar clock)
Bright Purple:  #7B2CBF (waybar audio)
Light Purple:   #9D4EDD (waybar network)
Accent Purple:  #BB86FC (borders, highlights)
Pale Purple:    #E0D0F0 (text accents)

/* State Colors */
Urgent Red:     #C24141 (errors, urgent items)
Active Blue:    #2B83A6 (activatable entries)
Separator:      #B7B7B7 (divider lines)
Scrollbar:      #555555 (handle)
```

## Animation Timeline

```
0ms     → Launcher slides in from left (400ms ease-in-out)
100ms   → Search box slides in from left
150ms   → First entry appears
180ms   → Second entry appears
210ms   → Third entry appears
240ms   → Fourth entry appears
270ms   → Fifth entry appears
300ms   → Remaining entries appear
```

## Configuration Options Explained

### Search Modes
- **fuzzy**: Hybrid algorithm, best for typos and partial matches
- **contains**: Simple substring matching
- **multi-contains**: Space-separated terms (AND logic)
- **strict-contains**: Exact containment without sorting

### Filter Rate
- **50ms**: Very responsive but higher CPU usage
- **100ms**: Balanced (previous setting)
- **200ms**: Lower CPU, slightly less responsive

### Dynamic Lines
- **false**: Fixed height (current)
- **true**: Shrinks to fit content (better for small result sets)

## Customization Tips

### Change Sidebar Width
```conf
width=600  # Wider sidebar
width=400  # Narrower sidebar
width=30%  # Percentage-based
```

### Adjust Animation Speed
In `style.css`, modify animation durations:
```css
animation: slideIn 0.5s ease-out;  /* Slower */
animation: slideIn 0.2s ease-out;  /* Faster */
```

### Disable Alternating Rows
Comment out in `style.css`:
```css
/* #entry:nth-child(even) {
    background-color: rgba(42, 42, 42, 0.2);
} */
```

### Change Icon Size
In `config`:
```conf
image_size=48  # Larger icons
image_size=24  # Smaller icons
```

### Disable Fuzzy Matching
In `config`:
```conf
matching=contains  # Simple substring matching
```

## Integration with Hyprland

Current layer rules in `hyprland.conf`:
```conf
layerrule = blur, wofi
layerrule = dimaround, wofi
layerrule = ignorezero, wofi
```

Current animation in `hyprland.conf`:
```conf
animation = layersIn, 1, 5, easeInOut, slide left
animation = layersOut, 1, 4, easeInOut, slide left
```

## Troubleshooting

### Icons Not Showing
- Ensure `allow_images=true` in config
- Check that applications have valid icon entries in `.desktop` files
- Verify icon themes are installed

### Search Not Working
- Check `matching=` setting
- Ensure `insensitive=true` for case-insensitive search
- Try `parse_search=false` if filtering is too aggressive

### Animations Choppy
- Reduce animation counts in CSS
- Increase `filter_rate` to 100ms or 200ms
- Disable `will-change` properties in CSS

### Launcher Won't Close
- Check Hyprland layer rules are correct
- Verify `key_exit=Escape` is set
- Try clicking outside the launcher

## Advanced Usage

### DMMenu Mode
Use wofi for custom scripts:
```bash
echo -e "Option 1\nOption 2\nOption 3" | wofi --dmenu
```

### Window Switcher (Sway/Hyprland)
```bash
hyprctl clients -j | jq -r '.[] | "\(.address)|\(.class)|\(.title)"' | \
    wofi --dmenu -p "Switch to:" | cut -d'|' -f1 | \
    xargs -I{} hyprctl dispatch focuswindow address:{}
```

### Clipboard History Integration
```bash
cliphist list | wofi --dmenu -p "Clipboard:" | cliphist decode | wl-copy
```

## File Structure
```
~/.config/wofi/
├── config        # Main configuration file
├── style.css     # Complete theme with animations
└── README.md     # This documentation
```

## Credits
- Original Oxide theme by Diki Ananta
- Purple palette from your waybar configuration
- Glassmorphic effects and animations: custom implementation
- Smart features based on wofi official documentation

## License
Inherits MIT license from original Oxide theme
