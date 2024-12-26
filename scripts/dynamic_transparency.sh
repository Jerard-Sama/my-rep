#!/bin/bash
# Dynamic transparency adjustment script for `st` terminals with xcompmgr

# Dependencies: xprop, xwininfo

# Global transparency percentages
GLOBAL_TRANSPARENCY=50  # Transparency for unfocused `st` terminals (in %)
FOCUSED_TRANSPARENCY=20 # Transparency for focused `st` terminals (in %)

# Convert percentage to hexadecimal value for _NET_WM_WINDOW_OPACITY
calculate_transparency_hex() {
    local percent=$1
    if [[ $percent -eq 0 ]]; then
        echo "0xffffffff"  # Fully opaque
    elif [[ $percent -eq 100 ]]; then
        echo "0x00000000"  # Fully transparent
    else
        echo $(printf "0x%x" $((4294967295 - 4294967295 * percent / 100)))
    fi
}

# Get the current focused window ID
get_focused_window() {
    xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}'
}

# Check if a window is an `st` terminal by its class
is_st_terminal() {
    local window_id=$1
    xprop -id "$window_id" | grep -q 'CLASS.*st' 2>/dev/null
}

# Apply transparency to a specific window
apply_transparency() {
    local window_id=$1
    local transparency_hex=$2
    xprop -id "$window_id" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "$transparency_hex" 2>/dev/null
}

# Monitor focus changes and update transparency for `st` terminals dynamically
monitor_focus() {
    local last_focused_window=""
    local global_transparency_hex=$(calculate_transparency_hex "$GLOBAL_TRANSPARENCY")
    local focused_transparency_hex=$(calculate_transparency_hex "$FOCUSED_TRANSPARENCY")

    while true; do
        # Get the currently focused window
        local current_focused_window=$(get_focused_window)

        # Apply transparency only to `st` terminals
        for window_id in $(xwininfo -root -tree | awk '/\"/ {print $1}' | grep -E '0x[0-9a-f]+'); do
            if is_st_terminal "$window_id"; then
                if [[ "$window_id" == "$current_focused_window" ]]; then
                    apply_transparency "$window_id" "$focused_transparency_hex"
                else
                    apply_transparency "$window_id" "$global_transparency_hex"
                fi
            fi
        done

        # Sleep to reduce CPU usage
        sleep 0.5
    done
}

# Start monitoring focus changes
monitor_focus

