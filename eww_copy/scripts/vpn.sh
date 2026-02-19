#!/bin/bash

# VPN Manager Script for eww
# Gestisce le connessioni VPN di NetworkManager (OpenVPN, WireGuard)

# Ottiene la lista delle VPN configurate in formato JSON
# Cerca connessioni di tipo: vpn (OpenVPN), wireguard
defpoll_vpn_list() {
    nmcli -t -f NAME,TYPE connection show | grep -E "(vpn|wireguard)" | cut -d':' -f1 | jq -R -s -c 'split("\n") | map(select(length > 0))'
}

# Verifica se una VPN specifica è connessa
is_vpn_connected() {
    local vpn_name="$1"
    nmcli -t -f NAME,DEVICE connection show --active | grep -q "^${vpn_name}:"
}

# Ottiene lo stato generale (se c'è almeno una VPN connessa)
get_vpn_status() {
    local active_vpns=$(nmcli -t -f NAME,TYPE connection show --active | grep -E "(vpn|wireguard)" | cut -d':' -f1)
    if [ -n "$active_vpns" ]; then
        echo "connected"
    else
        echo "disconnected"
    fi
}

# Ottiene il nome della VPN connessa (se c'è)
get_active_vpn_name() {
    nmcli -t -f NAME,TYPE connection show --active | grep -E "(vpn|wireguard)" | cut -d':' -f1 | head -n1
}

# Toggle una VPN (connetti/disconnetti)
toggle_vpn() {
    local vpn_name="$1"
    if is_vpn_connected "$vpn_name"; then
        nmcli connection down "$vpn_name" 2>/dev/null
    else
        nmcli connection up "$vpn_name" 2>/dev/null
    fi
}

# Genera JSON con tutte le VPN e il loro stato
get_vpn_list_with_status() {
    local vpn_list=$(nmcli -t -f NAME,TYPE connection show | grep -E "(vpn|wireguard)" | cut -d':' -f1)
    local result="["
    local first=true
    
    while IFS= read -r vpn_name; do
        [ -z "$vpn_name" ] && continue
        
        if [ "$first" = true ]; then
            first=false
        else
            result="${result},"
        fi
        
        local status="disconnected"
        if is_vpn_connected "$vpn_name"; then
            status="connected"
        fi
        
        # Escape del nome VPN per JSON
        local escaped_name=$(echo "$vpn_name" | sed 's/"/\\"/g')
        result="${result}{\"name\":\"${escaped_name}\",\"status\":\"${status}\"}"
    done <<< "$vpn_list"
    
    result="${result}]"
    echo "$result"
}

# Case per i comandi
case "$1" in
    list)
        defpoll_vpn_list
        ;;
    status)
        get_vpn_status
        ;;
    active)
        get_active_vpn_name
        ;;
    toggle)
        toggle_vpn "$2"
        ;;
    list-with-status)
        get_vpn_list_with_status
        ;;
    *)
        echo "Uso: $0 {list|status|active|toggle <vpn_name>|list-with-status}"
        exit 1
        ;;
esac
