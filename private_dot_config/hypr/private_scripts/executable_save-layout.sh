#!/usr/bin/env bash
# Hyprland Workspace Layout Saver
# Usage: ./save-layout.sh <layout-name> [workspace-id]

LAYOUT_DIR="$HOME/.config/hypr/layouts"
LAYOUT_NAME="${1:-snapshot-$(date +%Y%m%d-%H%M%S)}"
LAYOUT_FILE="$LAYOUT_DIR/$LAYOUT_NAME.layout"

# Create layouts directory if it doesn't exist
mkdir -p "$LAYOUT_DIR"

# Get target workspace (current workspace if not specified)
TARGET_WS="${2:-$(hyprctl activeworkspace -j | jq -r '.id')}"

echo "# Layout saved on $(date)" > "$LAYOUT_FILE"
echo "# Workspace: $TARGET_WS" >> "$LAYOUT_FILE"
echo "" >> "$LAYOUT_FILE"
echo "workspace $TARGET_WS" >> "$LAYOUT_FILE"
echo "" >> "$LAYOUT_FILE"

# Get all clients in the target workspace with full details
hyprctl clients -j | jq -r --arg ws "$TARGET_WS" '.[] | select(.workspace.id == ($ws | tonumber)) |
    "\(.address)|\(.class)|\(.title)|\(.at[0])|\(.at[1])|\(.size[0])|\(.size[1])|\(.pid)"' | \
while IFS='|' read -r address class title x y w h pid; do
    echo "# Window: $class - $title" >> "$LAYOUT_FILE"
    echo "# Position: ($x, $y) Size: ${w}x${h}" >> "$LAYOUT_FILE"

    # Special handling for kitty terminals - preserve the running command
    if [ "$class" = "kitty" ]; then
        # Get the shell process and its current command
        shell_pid=$(pgrep -P "$pid" | head -1)
        if [ -n "$shell_pid" ]; then
            # Try to get the current directory and command
            cwd=$(readlink -f "/proc/$shell_pid/cwd" 2>/dev/null)
            cmd=$(ps -p "$shell_pid" -o args= 2>/dev/null)

            # Check if there's a process running in the shell
            child_pid=$(pgrep -P "$shell_pid" | head -1)
            if [ -n "$child_pid" ]; then
                cmd=$(ps -p "$child_pid" -o args= 2>/dev/null)
                echo "# Running: $cmd" >> "$LAYOUT_FILE"
                echo "exec kitty --working-directory \"$cwd\" -e $cmd" >> "$LAYOUT_FILE"
            else
                echo "# Working directory: $cwd" >> "$LAYOUT_FILE"
                echo "exec kitty --working-directory \"$cwd\"" >> "$LAYOUT_FILE"
            fi
        else
            echo "exec kitty" >> "$LAYOUT_FILE"
        fi
    else
        # Other applications
        case "$class" in
            firefox|Firefox)
                echo "exec firefox" >> "$LAYOUT_FILE"
                ;;
            dolphin)
                echo "exec dolphin" >> "$LAYOUT_FILE"
                ;;
            code|Code)
                echo "exec code" >> "$LAYOUT_FILE"
                ;;
            chromium|Chromium)
                echo "exec chromium" >> "$LAYOUT_FILE"
                ;;
            discord|Discord)
                echo "exec discord" >> "$LAYOUT_FILE"
                ;;
            spotify|Spotify)
                echo "exec spotify" >> "$LAYOUT_FILE"
                ;;
            *)
                # Generic launcher
                echo "exec ${class,,}" >> "$LAYOUT_FILE"
                ;;
        esac
    fi

    echo "sleep 0.5" >> "$LAYOUT_FILE"

    # Add positioning commands - resize and move the active window
    echo "hyprctl dispatch resizewindowpixel exact $w $h" >> "$LAYOUT_FILE"
    echo "hyprctl dispatch movewindowpixel exact $x $y" >> "$LAYOUT_FILE"
    echo "" >> "$LAYOUT_FILE"
done

# Count windows saved
window_count=$(hyprctl clients -j | jq --arg ws "$TARGET_WS" '[.[] | select(.workspace.id == ($ws | tonumber))] | length')

echo "Layout saved to: $LAYOUT_FILE"
echo "Saved $window_count window(s) from workspace $TARGET_WS"
echo ""
echo "To restore this layout, run:"
echo "  ~/.config/hypr/scripts/load-layout.sh $LAYOUT_NAME"
