#!/bin/sh

current_rel() {
    brightnessctl --class=backlight --machine-readable |
        awk -F, 'NR == 1 { sub(/%$/, "", $4); print $4 }'
}

case $1'' in
'') ;;
'down')
    brightnessctl --class=backlight --quiet --min-value=1 set 3%-
    ;;
'up')
    brightnessctl --class=backlight --quiet set +3%
    ;;
esac

current_rel
