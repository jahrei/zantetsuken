#!/usr/bin/env bash
# Rofi Script Menu - Launch scripts with rofi
# Shows available scripts and layouts

SCRIPT_DIR="$HOME/.config/hypr/scripts"
LAYOUT_DIR="$HOME/.config/hypr/layouts"

# Build menu entries
menu_entries=()

# Add script actions
menu_entries+=("📸 Save Current Layout|save-layout")
menu_entries+=("📂 Load Layout|load-layout-menu")
menu_entries+=("🖼️  Screenshot (Area)|screenshot-area")
menu_entries+=("💾 Screenshot (Save)|screenshot-save")
menu_entries+=("📝 Screenshot (OCR)|screenshot-ocr")

# Get saved layouts
if [ -d "$LAYOUT_DIR" ]; then
    while IFS= read -r layout_file; do
        layout_name=$(basename "$layout_file" .layout)
        menu_entries+=("⚡ Layout: $layout_name|load-layout:$layout_name")
    done < <(find "$LAYOUT_DIR" -name "*.layout" -type f)
fi

# Display menu with rofi
selected=$(printf '%s\n' "${menu_entries[@]}" | \
    awk -F'|' '{print $1}' | \
    rofi -dmenu -i -p "Scripts" -theme-str 'window {width: 500px;}')

# Exit if nothing selected
[ -z "$selected" ] && exit 0

# Find the corresponding action
for entry in "${menu_entries[@]}"; do
    label="${entry%%|*}"
    action="${entry#*|}"

    if [ "$label" = "$selected" ]; then
        case "$action" in
            save-layout)
                # Prompt for layout name
                layout_name=$(rofi -dmenu -p "Layout name" -theme-str 'window {width: 400px;}')
                if [ -n "$layout_name" ]; then
                    "$SCRIPT_DIR/save-layout.sh" "$layout_name"
                    notify-send "Layout Saved" "Saved as: $layout_name"
                fi
                ;;

            load-layout-menu)
                # Show layout selection
                layout=$(find "$LAYOUT_DIR" -name "*.layout" -type f -exec basename {} .layout \; | \
                    rofi -dmenu -i -p "Select Layout" -theme-str 'window {width: 400px;}')
                if [ -n "$layout" ]; then
                    "$SCRIPT_DIR/load-layout.sh" "$layout"
                fi
                ;;

            screenshot-area)
                "$SCRIPT_DIR/screenshot.sh" clipboard
                ;;

            screenshot-save)
                "$SCRIPT_DIR/screenshot.sh" save
                ;;

            screenshot-ocr)
                "$SCRIPT_DIR/screenshot.sh" ocr
                ;;

            load-layout:*)
                layout_name="${action#load-layout:}"
                "$SCRIPT_DIR/load-layout.sh" "$layout_name"
                notify-send "Layout Loaded" "$layout_name"
                ;;
        esac
        break
    fi
done
