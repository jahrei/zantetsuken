#!/bin/bash
# Xbox 360 Blades-style keybind reference using rofi script mode
# Left/Right to switch categories

CONFIG="$HOME/.config/hypr/hyprland.conf"
ESPANSO="$HOME/.config/espanso/match/base.yml"
STATE_FILE="/tmp/keybinds-blade"

BLADES=("WINDOW" "LAUNCH" "NAVIGATE" "MEDIA" "ESPANSO")

# Script mode: rofi calls this script repeatedly
if [[ -n "$ROFI_RETV" ]]; then
    # Get current blade
    blade_idx=$([[ -f "$STATE_FILE" ]] && cat "$STATE_FILE" || echo 0)
    total=${#BLADES[@]}

    # Handle selection
    case "$ROFI_RETV" in
        1) # Selected entry - check if it's navigation
            if [[ "$1" == "◀ PREV" ]]; then
                blade_idx=$(( (blade_idx - 1 + total) % total ))
                echo "$blade_idx" > "$STATE_FILE"
            elif [[ "$1" == "NEXT ▶" ]]; then
                blade_idx=$(( (blade_idx + 1) % total ))
                echo "$blade_idx" > "$STATE_FILE"
            else
                exit 0
            fi
            ;;
        10) # kb-custom-1: Left
            blade_idx=$(( (blade_idx - 1 + total) % total ))
            echo "$blade_idx" > "$STATE_FILE"
            ;;
        11) # kb-custom-2: Right
            blade_idx=$(( (blade_idx + 1) % total ))
            echo "$blade_idx" > "$STATE_FILE"
            ;;
    esac

    blade="${BLADES[$blade_idx]}"

    # Set prompt to show current blade with navigation hints
    echo -en "\0prompt\x1f◀  ${blade}  ▶\n"
    echo -en "\0message\x1f← →  navigate blades\n"

    # Navigation entries at top
    echo "◀ PREV"
    echo "NEXT ▶"
    echo "─────────────────────────────"

    # Content based on blade
    case "$blade" in
        WINDOW)
            grep -E "^bind.*=.*\\\$mainMod.*(kill|exit|float|pseudo|split|fullscreen)" "$CONFIG" 2>/dev/null | while read -r line; do
                parse_line "$line"
            done
            ;;
        LAUNCH)
            grep -E "^bind.*=.*exec," "$CONFIG" 2>/dev/null | while read -r line; do
                parse_line "$line"
            done
            ;;
        NAVIGATE)
            grep -E "^bind.*=.*(focus|workspace)" "$CONFIG" 2>/dev/null | grep -vi "mouse" | head -20 | while read -r line; do
                parse_line "$line"
            done
            ;;
        MEDIA)
            grep -E "^bind.*=.*(audio|volume|bright|player|screen)" "$CONFIG" 2>/dev/null | while read -r line; do
                parse_line "$line"
            done
            ;;
        ESPANSO)
            if [[ -f "$ESPANSO" ]]; then
                trigger="" comment=""
                while IFS= read -r line; do
                    # Capture any comment
                    if [[ "$line" =~ ^[[:space:]]*#[[:space:]]*(.+) ]]; then
                        comment="${BASH_REMATCH[1]}"
                    fi
                    # Get trigger
                    if [[ "$line" =~ trigger:[[:space:]]*\"(.+)\" ]]; then
                        trigger="${BASH_REMATCH[1]}"
                    fi
                    # Get replace and output
                    if [[ "$line" =~ replace:[[:space:]]*\"(.+)\" && -n "$trigger" ]]; then
                        replace="${BASH_REMATCH[1]}"
                        # Use comment if descriptive, else truncate replace
                        if [[ "$comment" =~ ^claude[[:space:]]code ]]; then
                            desc="${comment#*- }"
                        else
                            desc="${replace:0:35}"
                            [[ ${#replace} -gt 35 ]] && desc="${desc}..."
                        fi
                        printf "%-10s  %s\n" "$trigger" "$desc"
                        trigger="" ; comment=""
                    fi
                done < "$ESPANSO"
            fi
            ;;
    esac
    exit 0
fi

# Helper function to parse bind lines
parse_line() {
    local line="$1"
    local rest="${line#*= }"
    local comment=""

    if [[ "$rest" == *"#"* ]]; then
        comment="${rest##*\# }"
        rest="${rest%%\#*}"
    fi

    IFS=',' read -r mod key action params <<< "$rest"
    mod="${mod// /}"; key="${key// /}"
    mod="${mod//\$mainMod/Super}"
    mod="${mod//SHIFT/⇧}"

    [[ -n "$mod" ]] && keycombo="$mod+$key" || keycombo="$key"

    if [[ -n "$comment" ]]; then
        desc="$comment"
    else
        desc="${action//exec,/}"
        desc="${desc##*/}"
        desc="${desc:0:25}"
    fi

    printf "%-18s  %s\n" "$keycombo" "$desc"
}

export -f parse_line
export CONFIG ESPANSO STATE_FILE BLADES

# Initialize state
echo "0" > "$STATE_FILE"

# Launch rofi in script mode
rofi -show keybinds -modi "keybinds:$0" \
    -kb-custom-1 "Left" \
    -kb-custom-2 "Right" \
    -kb-move-char-back "" \
    -kb-move-char-forward "" \
    -theme-str 'window {width: 500px; border-radius: 16px; location: center; anchor: center;}' \
    -theme-str 'listview {lines: 18; scrollbar: false; padding: 8px 0;}' \
    -theme-str 'element {padding: 6px 16px;}' \
    -theme-str 'element-text {font: "monospace 10";}' \
    -theme-str 'inputbar {enabled: false;}' \
    -theme-str 'message {padding: 12px;}'

rm -f "$STATE_FILE"
