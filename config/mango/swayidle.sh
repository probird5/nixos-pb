#!/usr/bin/env bash
# swayidle configuration for MangoWC
# Handles screen lock, DPMS, and suspend on idle
#
# Timeouts:
#   5 min (300s) - Lock screen with swaylock-effects
#   5.5 min (330s) - Turn off displays via wlr-randr
#   10 min (600s) - Suspend system

SWAYLOCK_CMD="swaylock -f -C ~/.config/mango/swaylock.conf"

exec swayidle -w \
    timeout 300 "pidof swaylock || $SWAYLOCK_CMD" \
    timeout 330 'wlr-randr --output DP-2 --off; wlr-randr --output DP-3 --off' \
        resume 'wlr-randr --output DP-2 --on; wlr-randr --output DP-3 --on' \
    timeout 600 'systemctl suspend' \
    before-sleep "pidof swaylock || $SWAYLOCK_CMD" \
    after-resume 'wlr-randr --output DP-2 --on; wlr-randr --output DP-3 --on'
