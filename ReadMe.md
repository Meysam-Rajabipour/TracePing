raceping Traceping is a PowerShell script for Windows that combines the functionality of tracert (traceroute) and ping to trace network hops to a target host or IP address and measure the average ping time for each hop. It provides a colorful, real-time, and aligned output, making it easy to analyze network paths and latency. Traceping Screenshot Features Real-Time Output: Displays each hop as it is processed, similar to Windows tracert.

Ping Times: Measures and displays the average ping time for each hop (based on 2 pings for speed).

Colorful Display: Uses distinct colors for hop numbers (yellow), IP addresses (green), ping times (magenta), and headers (cyan).

Aligned Columns: Outputs results in a neat, table-like format for readability.

Help Option: Run Traceping.ps1 /? to view usage instructions and examples.

Optimized Performance: Uses minimal pings and disables DNS lookups for faster execution.

Lightweight: A single PowerShell script with no external dependencies beyond Windows.

Prerequisites Windows OS: Windows 7 or later (tested on Windows 10 and 11).

PowerShell: PowerShell 5.1 or later (included with Windows 10/11; available for Windows 7/8).

**tracert and Test-Connection: Built-in Windows commands used by the script (available by default).

Execution Policy: PowerShell execution policy must allow running scripts. Run the following to set it (if needed): powershell

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned



Alternatively, download Traceping.ps1 from the repository directly.

Place the Script: Save Traceping.ps1 in a directory of your choice (e.g., C:\Scripts).

(Optional) Add the directory to your PowerShell profile’s $env:PATH for easy access: powershell

$env:Path += ";C:\Scripts"

Verify Execution Policy: Ensure PowerShell allows running scripts: powershell

Get-ExecutionPolicy

If set to Restricted, change it: powershell

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

Usage Run Traceping.ps1 from PowerShell with a target host or IP address. Syntax powershell

.\Traceping.ps1 <host/IP>

Options <host/IP>: The target hostname (e.g., google.com) or IP address (e.g., 8.8.8.8) to trace.

/? or -?: Displays the help message with usage instructions and examples.

Examples Trace hops to google.com: powershell

.\Traceping.ps1 google.com

Output (colorful and real-time):

Hop IP Ping
1 10.254.250.1 3 ms
2 178.238.96.4 5.75 ms
3 178.238.96.85 6.75 ms
...

Trace hops to 8.8.8.8: powershell

.\Traceping.ps1 8.8.8.8

View help: powershell

.\Traceping.ps1 /?

Output:

Traceping - A tool to trace network hops and measure ping times

Usage: Traceping.ps1 <host/IP>

Parameters: <host/IP> The target hostname or IP address to trace (e.g., google.com, 8.8.8.8) /? or -? Displays this help message

Examples: Traceping.ps1 google.com Traceping.ps1 8.8.8.8

Output: Displays each hop with its number, IP address, and average ping time in a colorful, aligned format.

Running without arguments also shows the help message: powershell

.\Traceping.ps1

Running from Any Directory To run Traceping.ps1 without specifying the full path: Place Traceping.ps1 in a directory like C:\Scripts.

Add the directory to your PowerShell $env:PATH: powershell

$env:Path += ";C:\Scripts"

Run the script from any PowerShell session: powershell

Traceping.ps1 google.com

Notes Execution Policy: If you encounter a "cannot be loaded because running scripts is disabled" error, adjust the execution policy as described in the Prerequisites section.

Colors: The colorful output works best in PowerShell or Windows Terminal. If colors don’t display correctly, ensure your console supports ANSI colors.

Timeouts: Hops that timeout are displayed as "Timeout" in the ping column, maintaining alignment.

Performance: The script uses 2 pings per hop for speed. To change this, edit the Get-PingTime function in Traceping.ps1 (modify -Count 2).

Customization: You can modify Traceping.ps1 to change colors, ping count, or add features like logging. See the script’s comments for details.

Contributing Contributions are welcome! To contribute: Fork the repository.

Create a new branch (git checkout -b feature/your-feature).

Make your changes to Traceping.ps1.

Test thoroughly in PowerShell.

Submit a pull request with a clear description of your changes.

Please report bugs or suggest features via the Issues page. License This project is licensed under the MIT License. See the LICENSE file for details. Acknowledgments Built with PowerShell, leveraging Windows’ built-in tracert and Test-Connection commands.

Inspired by the need for a user-friendly, colorful alternative to tracert with ping functionality.
