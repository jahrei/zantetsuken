#!/usr/bin/env bash
# Hyprland Workspace Layout Loader
# Usage: ./load-layout.sh <layout-name>

LAYOUT_DIR="$HOME/.config/hypr/layouts"
LAYOUT_NAME="${1:-default}"
LAYOUT_FILE="$LAYOUT_DIR/$LAYOUT_NAME.layout"

if [ ! -f "$LAYOUT_FILE" ]; then
    echo "Layout '$LAYOUT_NAME' not found at $LAYOUT_FILE"
    echo "Available layouts:"
    ls -1 "$LAYOUT_DIR" | sed 's/.layout$//'
    exit 1
fi

# Get current workspace (stay on current workspace, don't switch)
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r '.id')

# Read and execute layout file
while IFS= read -r line || [ -n "$line" ]; do
    # Skip comments and empty lines
    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue

    # Parse layout commands
    if [[ "$line" =~ ^workspace[[:space:]]+([0-9]+)$ ]]; then
        # Skip workspace switching - we stay on current workspace
        continue

    elif [[ "$line" =~ ^exec[[:space:]]+(.+)$ ]]; then
        CMD="${BASH_REMATCH[1]}"
        eval "$CMD &"
        sleep 0.3

    elif [[ "$line" =~ ^hy3:(.+)$ ]]; then
        HY3_CMD="${BASH_REMATCH[1]}"
        hyprctl dispatch "hy3:$HY3_CMD"
        sleep 0.2

    elif [[ "$line" =~ ^hyprctl[[:space:]]+dispatch[[:space:]]+(.+)$ ]]; then
        HYPR_CMD="${BASH_REMATCH[1]}"
        hyprctl dispatch $HYPR_CMD
        sleep 0.1

    elif [[ "$line" =~ ^sleep[[:space:]]+([0-9.]+)$ ]]; then
        sleep "${BASH_REMATCH[1]}"
    fi
done < "$LAYOUT_FILE"

echo "Layout '$LAYOUT_NAME' loaded successfully in workspace $CURRENT_WS!"
