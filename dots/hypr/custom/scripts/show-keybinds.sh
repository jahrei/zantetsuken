#!/bin/bash
# Display Hyprland keybindings in a searchable rofi menu
# Optimized for instant loading

CONFIG="$HOME/.config/hypr/hyprland.conf"

# Fast parsing with single pass and minimal subshells
{
    echo "=== HYPRLAND KEYBINDINGS ==="
    echo ""

    while IFS= read -r line; do
        # Category detection
        case "$line" in
            "# Screenshot keybindings"|"# "*)
                if [[ "$line" =~ ^#\ [A-Z].*keybind ]]; then
                    echo ""
                    echo "[${line#\# }]"
                fi
                continue
                ;;
        esac

        # Only process bind lines
        [[ "$line" =~ ^bind[mel]*\ *= ]] || continue

        # Skip submap lines
        [[ "$line" =~ submap ]] && continue

        # Fast extraction using bash parameter expansion
        rest="${line#*= }"

        # Get comment if exists
        if [[ "$rest" == *"#"* ]]; then
            comment="${rest##*\# }"
            rest="${rest%%\#*}"
        else
            comment=""
        fi

        # Parse: modifier, key, action, params
        IFS=',' read -r mod key action params <<< "$rest"

        # Clean up whitespace
        mod="${mod# }"; mod="${mod% }"
        key="${key# }"; key="${key% }"
        action="${action# }"; action="${action% }"

        # Replace $mainMod
        mod="${mod//\$mainMod/SUPER}"

        # Format key combo
        if [[ -n "$mod" ]]; then
            keycombo="$mod + $key"
        else
            keycombo="$key"
        fi

        # Use comment or action as description
        desc="${comment:-$action}"

        printf "  %-28s → %s\n" "$keycombo" "$desc"
    done < "$CONFIG"
} | rofi -dmenu -i -p "Keybindings" \
    -theme-str 'window {width: 50%; height: 60%; location: center; anchor: center;}' \
    -theme-str 'listview {lines: 20;}' \
    -theme-str 'element-text {font: "monospace 10";}' \
    -mesg "Press ESC to close"
