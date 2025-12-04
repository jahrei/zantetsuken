#!/bin/bash
# Quick RGB control script for Asiahorse Venom fans
# Device 1, Zone 0 (Aura Addressable 1)

DEVICE=1
ZONE=0

case "$1" in
    blue)
        echo "Setting RGB to blue..."
        openrgb --device $DEVICE --zone $ZONE --mode direct --color 0000FF
        ;;
    cyan)
        echo "Setting RGB to cyan-blue (theme color)..."
        openrgb --device $DEVICE --zone $ZONE --mode direct --color 7dd3fc
        ;;
    red)
        echo "Setting RGB to red..."
        openrgb --device $DEVICE --zone $ZONE --mode direct --color FF0000
        ;;
    green)
        echo "Setting RGB to green..."
        openrgb --device $DEVICE --zone $ZONE --mode direct --color 00FF00
        ;;
    purple)
        echo "Setting RGB to purple..."
        openrgb --device $DEVICE --zone $ZONE --mode direct --color 9b59b6
        ;;
    white)
        echo "Setting RGB to white..."
        openrgb --device $DEVICE --zone $ZONE --mode direct --color FFFFFF
        ;;
    off)
        echo "Turning RGB off..."
        openrgb --device $DEVICE --zone $ZONE --mode off
        ;;
    rainbow)
        echo "Setting RGB to rainbow cycle..."
        openrgb --device $DEVICE --zone $ZONE --mode "Spectrum Cycle"
        ;;
    breathing)
        echo "Setting RGB to breathing mode..."
        openrgb --device $DEVICE --zone $ZONE --mode breathing --color 0000FF
        ;;
    theme)
        echo "Syncing with Hyprland theme..."
        ~/.config/hypr/scripts/rgb-theme-sync.sh
        ;;
    *)
        echo "RGB Control for Asiahorse Venom Fans"
        echo ""
        echo "Usage: $0 [mode]"
        echo ""
        echo "Available modes:"
        echo "  blue       - Solid blue"
        echo "  cyan       - Cyan-blue (matches theme accent)"
        echo "  red        - Solid red"
        echo "  green      - Solid green"
        echo "  purple     - Solid purple"
        echo "  white      - Solid white"
        echo "  off        - Turn off LEDs"
        echo "  rainbow    - Rainbow spectrum cycle"
        echo "  breathing  - Breathing effect (blue)"
        echo "  theme      - Sync with Hyprland color theme"
        echo ""
        echo "Examples:"
        echo "  $0 blue"
        echo "  $0 rainbow"
        echo "  $0 theme"
        ;;
esac
