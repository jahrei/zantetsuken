#!/bin/bash
# RGB LED scheduler - Auto off at 9pm, auto on at 6am
# Runs periodically to ensure correct state even after power cycles

DEVICE=1
ZONE=0
CURRENT_HOUR=$(date +%H)

# Convert to integer for comparison
CURRENT_HOUR=$((10#$CURRENT_HOUR))

# Check if we're in "off hours" (9pm to 6am = 21:00 to 06:00)
if [ $CURRENT_HOUR -ge 21 ] || [ $CURRENT_HOUR -lt 6 ]; then
    # Night time - LEDs should be off
    echo "[$(date)] Night mode: Turning LEDs off (current hour: $CURRENT_HOUR)"
    openrgb --device $DEVICE --zone $ZONE --mode off
else
    # Day time - LEDs should be on with purple color
    echo "[$(date)] Day mode: Setting LEDs to purple (current hour: $CURRENT_HOUR)"
    openrgb --device $DEVICE --zone $ZONE --mode direct --color 9b59b6
fi
