# Wi-Fi Deauthentication Tool

> **⚠️ Legal notice:**
> This script is for **educational and authorized security testing only**.
> Running deauthentication attacks on networks or devices you do **not** own or have explicit permission to test is illegal in many countries.

## Overview

This interactive Bash script provides a menu-driven interface to:

* Scan for nearby Wi-Fi networks
* Select a target network
* Send deauthentication packets to a specific client or all clients
* Check or change the active Wi-Fi adapter

It leverages the `aircrack-ng` suite (`airodump-ng`, `aireplay-ng`) for scanning and deauthentication.

---

## Requirements

* **Linux** system (tested on Kali/Ubuntu/Debian-based distributions)
* Wireless adapter that supports **monitor mode** and packet injection
* `aircrack-ng` installed

  ```bash
  sudo apt install aircrack-ng
  ```
* `iw` / `iwconfig` utilities

---

## Setup

1. Save the script, e.g. `wifi-deauth.sh`.
2. Make it executable:

   ```bash
   chmod +x wifi-deauth.sh
   ```
3. Run with root privileges:

   ```bash
   sudo ./wifideauth.sh
   ```

---

## Usage

The script presents a numbered menu:

| Option | Action                                                                                           |
| ------ | ------------------------------------------------------------------------------------------------ |
| 1      | **Scan for Wi-Fi networks** – uses `airodump-ng` on the current interface (`wlan0` by default).  |
| 2      | **Select a Wi-Fi network** – enter BSSID and channel to focus scanning on that network.          |
| 3      | **Deauthenticate a specific client** – send a chosen number of deauth packets to one client MAC. |
| 4      | **Deauthenticate all clients** – send deauth packets to every client on the chosen BSSID.        |
| 5      | **Check Wi-Fi adapter status** – display current mode and details via `iwconfig`.                |
| 6      | **Change Wi-Fi adapter name** – update the interface (e.g. `wlan1mon`).                          |
| 7      | **Exit** – quit the tool.                                                                        |

**Example workflow**

1. Put your adapter in monitor mode (outside the script):

   ```bash
   sudo airmon-ng start wlan0
   ```

   This often creates `wlan0mon`.
2. Start the script and use option `6` to set the interface to `wlan0mon`.
3. Scan (option `1`) and identify the target BSSID and channel.
4. Use option `2` to lock onto the network.
5. Choose option `3` or `4` to send deauthentication packets.

---

## Notes

* **Revert to managed mode** after testing:

  ```bash
  sudo airmon-ng stop wlan0mon
  sudo systemctl start NetworkManager
  ```
* Adjust packet count carefully to avoid unnecessary disruption even on your own lab network.

---

## Disclaimer

This tool is intended **solely for penetration testing and security research** on networks you own or are explicitly authorized to assess. The author and contributors assume **no liability** for misuse or damages.

---
