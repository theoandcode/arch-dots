#!/usr/bin/env bash
# Waybar custom/playerctl module — polled, no --follow
# Targets plasma-browser-integration first, falls back to any other player.
# Emits idle placeholder when no player is active.

PLAYER_ARGS="--player=plasma-browser-integration,%any"

STATUS=$(playerctl $PLAYER_ARGS status 2>/dev/null)

if [[ -z "$STATUS" || "$STATUS" == "Stopped" ]]; then
    printf '{"text": "", "tooltip": "No media playing", "alt": "Stopped", "class": "Stopped"}\n'
    exit 0
fi

playerctl $PLAYER_ARGS metadata \
    --format '{"text": "  {{title}} \u2013 {{artist}}", "tooltip": "{{title}} \u2013 {{artist}}", "alt": "{{status}}", "class": "{{status}}"}' \
    2>/dev/null
