#!/bin/bash

# Toggle power menu script for eww

if eww list-windows | grep -q "\*vpnmenu"; then
    eww close vpnmenu
fi

if eww list-windows | grep -q "\*powermenu"; then
    eww close powermenu
else
    eww open powermenu
fi
