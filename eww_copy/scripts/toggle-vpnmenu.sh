#!/bin/bash

# Toggle VPN menu script for eww

if eww list-windows | grep -q "\*powermenu"; then
    eww close powermenu
fi

if eww list-windows | grep -q "\*vpnmenu"; then
    eww close vpnmenu
else
    eww open vpnmenu
fi
