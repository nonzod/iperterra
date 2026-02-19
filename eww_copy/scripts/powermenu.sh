#!/bin/bash

# Power menu script for eww

options="⏻ Spegni\n Riavvia\n󰒲 Sospendi\n Blocca"

chosen=$(echo -e "$options" | wofi --dmenu -i -p "Menu di sistema" --width 250 --height 200)

case $chosen in
    "⏻ Spegni")
        systemctl poweroff
        ;;
    " Riavvia")
        systemctl reboot
        ;;
    "󰒲 Sospendi")
        systemctl suspend
        ;;
    " Blocca")
        hyprlock
        ;;
esac
