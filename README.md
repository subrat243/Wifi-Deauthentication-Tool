```markdown
# Wi-Fi Deauthentication Tool

A Bash script for performing Wi-Fi deauthentication attacks using the Aircrack-ng suite. This tool is designed for educational purposes and authorized penetration testing.

![Wi-Fi Deauthentication Tool](https://img.shields.io/badge/License-MIT-blue.svg) ![Bash](https://img.shields.io/badge/Language-Bash-green.svg)

## Disclaimer
**This tool is for educational and authorized penetration testing purposes only.** Unauthorized use is illegal. Ensure you have explicit permission before testing any network. The developers are not responsible for misuse.

## Features
- Scan for nearby Wi-Fi networks.
- Select a target network for further actions.
- Deauthenticate specific clients or all clients from a network.
- Toggle monitor mode for the Wi-Fi adapter.
- Validate user inputs (BSSID, MAC address, channel, etc.).
- Check Wi-Fi adapter status and change the interface name.

## Prerequisites
- Linux-based operating system (e.g., Kali Linux, Ubuntu).
- A Wi-Fi adapter capable of monitor mode (e.g., Alfa AWUS036ACH).
- Root privileges (required for monitor mode and packet injection).
- Aircrack-ng suite installed.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/xyz/wifideauth.git
   cd wifideauth
   ```

2. Install the Aircrack-ng suite (if not already installed):
   ```bash
   sudo apt update && sudo apt install aircrack-ng
   ```

3. Make the script executable:
   ```bash
   chmod +x wifideauth.sh
   ```

## Usage
Run the script with root privileges:
```bash
sudo ./wifideauth.sh
```

### Menu Options
1. **Scan for Wi-Fi networks**: Lists all nearby networks.
2. **Select a Wi-Fi network**: Enter the BSSID and channel to monitor.
3. **Deauthenticate a client**: Specify the BSSID, client MAC, and packet count.
4. **Deauthenticate all clients**: Specify the BSSID and packet count.
5. **Check Wi-Fi adapter status**: Displays interface details.
6. **Change Wi-Fi adapter interface name**: Update the interface name (e.g., `wlan0`).
7. **Enable monitor mode**: Puts the adapter into monitor mode.
8. **Disable monitor mode**: Returns the adapter to managed mode.
9. **Exit**: Terminates the script.

## Screenshots
![Scan Networks](screenshots/scan.png)
*Example: Scanning for nearby networks.*

![Deauthenticate Client](screenshots/deauth.png)
*Example: Deauthenticating a specific client.*

## Legal and Ethical Considerations
- **Permission**: Always obtain written permission before testing any network.
- **Laws**: Familiarize yourself with local laws regarding wireless security testing.
- **Responsibility**: Use this tool ethically and only for legitimate purposes.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for improvements or bug fixes.

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

**Note**: This tool is part of a cybersecurity toolkit and should be used responsibly.
```
