#Usefull command to Trace and Ping at the same time
# Check command-line arguments
param (
    [Parameter(Mandatory=$false)]
    [string]$targetHost
)

# Function to display help message
function Show-Help {
    Write-Host "Traceping - A tool to trace network hops and measure ping times" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage: Traceping.exe <host/IP>" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  <host/IP>    The target hostname or IP address to trace (e.g., google.com, 8.8.8.8)"
    Write-Host "  /? or -?     Displays this help message"
    Write-Host ""
    Write-Host "Examples:" -ForegroundColor Yellow
    Write-Host "  Traceping.exe google.com"
    Write-Host "  Traceping.exe 8.8.8.8"
    Write-Host ""
    Write-Host "Output:" -ForegroundColor Yellow
    Write-Host "  Displays each hop with its number, IP address, and average ping time in a colorful, aligned format."
    Write-Host ""
    exit 0
}

# Check for help flag or no arguments
if ($targetHost -eq "/?" -or $targetHost -eq "-?" -or [string]::IsNullOrEmpty($targetHost)) {
    Show-Help
}

# Validate the input (basic check for non-empty string)
if (-not $targetHost) {
    Write-Host "Error: Please provide a target host or IP (e.g., Traceping.exe google.com)" -ForegroundColor Red
    Write-Host "Use 'Traceping.exe /?' for help." -ForegroundColor Red
    exit 1
}

# Run tracert and capture the output
$tracertOutput = tracert -d $targetHost  # -d prevents DNS lookups for faster execution

# Extract the hops from the tracert output, skipping empty lines and headers
$hops = $tracertOutput | Select-String -Pattern "^\s*\d+\s+.*\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | 
        Where-Object { $_ -notmatch "Tracing route" -and $_ -notmatch "Trace complete" }

# Function to ping a host and return the average time (optimized for speed)
function Get-PingTime {
    param (
        [string]$targetHost
    )
    try {
        # Reduced ping count to 2 for faster execution
        $pingOutput = Test-Connection -ComputerName $targetHost -Count 2 -ErrorAction Stop
        $avgTime = ($pingOutput | Measure-Object ResponseTime -Average).Average
        return [math]::Round($avgTime, 2)
    }
    catch {
        return "Timeout"
    }
}

# Display header with colors
Write-Host ("{0,-5} {1,-15} {2,-10}" -f "Hop", "IP", "Ping") -ForegroundColor Cyan

# Process and display each hop in real-time
foreach ($hop in $hops) {
    # Convert the hop line to string and split on whitespace, filtering out empty strings
    $hopLine = $hop.ToString()
    $hopDetails = $hopLine -split "\s+" | Where-Object { $_ }
    
    # Extract hop number (first number in the line)
    $hopNumber = $hopDetails[0]
    
    # Extract IP address (last valid IP in the line)
    $hopIP = $hopDetails | Where-Object { $_ -match "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" } | Select-Object -Last 1
    
    # Skip if no valid IP was found
    if (-not $hopIP) {
        continue
    }
    
    # Clean IP address (remove brackets if present)
    $hopIP = $hopIP -replace "[\[\]]", ""
    
    # Verify hop number is numeric
    if ($hopNumber -notmatch "^\d+$") {
        continue
    }
    
    # Get-switching time and display immediately
    $pingTime = Get-PingTime -targetHost $hopIP
    
    # Colorful output with fixed-width columns
    Write-Host ("{0,-5}" -f $hopNumber) -ForegroundColor Yellow -NoNewline
    Write-Host (" {0,-15}" -f $hopIP) -ForegroundColor Green -NoNewline
    Write-Host (" {0,-10}" -f "$pingTime ms") -ForegroundColor Magenta
}
