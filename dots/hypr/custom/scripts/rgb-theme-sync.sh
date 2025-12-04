#!/bin/bash
# Sync OpenRGB with Hyprland Matugen theme colors
# Applies the primary blue color from your theme to your RGB

# Extract primary color from Hyprland colors.conf
PRIMARY_COLOR=$(grep "^\$primary " ~/.config/hypr/colors.conf | grep -o "rgba([0-9a-f]\{6\}" | sed 's/rgba(//')

# Convert to RGB format for OpenRGB (remove the 'ff' alpha)
RGB_COLOR=${PRIMARY_COLOR:0:6}

echo "Setting RGB to theme color: #$RGB_COLOR"

# Apply to Zone 0 (Aura Addressable 1 - your fans)
openrgb --device 1 --zone 0 --mode direct --color "$RGB_COLOR"

echo "✅ RGB synced with Hyprland theme!"
