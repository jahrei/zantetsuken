#!/bin/bash
# Advanced window switcher for Hyprland
# Shows all windows with titles and allows jumping to selected window

# Get all clients with their address, class, and title
# Format output for rofi display
windows=$(hyprctl clients -j | jq -r '.[] |
    "\(.address)|\(.class)|\(.title)|\(.workspace.id)"' |
    while IFS='|' read -r addr class title workspace; do
        # Truncate long titles
        if [ ${#title} -gt 60 ]; then
            title="${title:0:57}..."
        fi

        # Format: [Workspace] Class: Title
        printf "%-70s [WS:%s] (%s)\n" "$title" "$workspace" "$class" | sed "s/^/[${addr}] /"
    done
)

# Check if there are any windows
if [ -z "$windows" ]; then
    notify-send "Window Switcher" "No windows found"
    exit 0
fi

# Show in rofi and get selection
selected=$(echo "$windows" | rofi -dmenu -i -p "Jump to window" \
    -theme-str 'window {width: 60%; height: 50%; location: center; anchor: center;}' \
    -theme-str 'listview {lines: 15;}' \
    -theme-str 'element-text {font: "monospace 9";}' \
    -mesg "Select a window to focus")

# Exit if nothing selected
[ -z "$selected" ] && exit 0

# Extract the address from the selection
addr=$(echo "$selected" | grep -oP '^\[\K0x[0-9a-f]+')

# Focus the selected window
if [ -n "$addr" ]; then
    hyprctl dispatch focuswindow "address:$addr"
fi
