#!/usr/bin/env bash
# Waybar custom/playerctl module — polled, no --follow
# Emits idle placeholder when no player is active.

STATUS=$(playerctl status 2>/dev/null)

if [[ -z "$STATUS" || "$STATUS" == "Stopped" ]]; then
    printf '{"text": "", "tooltip": "No media playing", "alt": "Stopped", "class": "Stopped"}\n'
    exit 0
fi

playerctl metadata \
    --format '{"text": "  {{title}} \u2013 {{artist}}", "tooltip": "{{title}} \u2013 {{artist}}", "alt": "{{status}}", "class": "{{status}}"}' \
    2>/dev/null
