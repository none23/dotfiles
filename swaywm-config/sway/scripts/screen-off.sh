#!/bin/sh

# Allow the shortcut keys to be released before turning the displays off.
# Ignore any swayidle config, and exit after the first wake-up.
exec swayidle -C /dev/null -w \
    timeout 1 'swaymsg "output * power off"' \
    resume "swaymsg 'output * power on'; kill -TERM $$"
