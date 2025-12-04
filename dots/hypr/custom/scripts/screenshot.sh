#!/bin/bash
# Screenshot script with multiple modes for Hyprland
# Usage: screenshot.sh [clipboard|save|ocr]

MODE="${1:-clipboard}"
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

case "$MODE" in
    clipboard)
        # Screenshot to clipboard
        grim -g "$(slurp)" - | wl-copy
        notify-send "Screenshot" "Copied to clipboard" -t 2000
        ;;

    save)
        # Screenshot, save to file, and copy to clipboard
        FILENAME="$SCREENSHOT_DIR/screenshot_$(date +%Y%m%d_%H%M%S).png"
        grim -g "$(slurp)" "$FILENAME"
        wl-copy < "$FILENAME"
        notify-send "Screenshot" "Saved and copied to clipboard" -t 3000
        ;;

    ocr)
        # Screenshot with OCR (requires tesseract)
        if ! command -v tesseract &> /dev/null; then
            notify-send "Screenshot OCR" "Tesseract not installed. Run: sudo pacman -S tesseract tesseract-data-eng" -t 5000
            exit 1
        fi

        TEMP_IMG=$(mktemp /tmp/screenshot-XXXXXX.png)
        grim -g "$(slurp)" "$TEMP_IMG"

        # Extract text using tesseract
        TEXT=$(tesseract "$TEMP_IMG" - 2>/dev/null)

        if [ -n "$TEXT" ]; then
            echo -n "$TEXT" | wl-copy
            notify-send "Screenshot OCR" "Text copied to clipboard" -t 2000
        else
            notify-send "Screenshot OCR" "No text detected" -t 2000
        fi

        rm -f "$TEMP_IMG"
        ;;

    *)
        echo "Usage: $0 [clipboard|save|ocr]"
        exit 1
        ;;
esac
