
# Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# PowerShell Core
choco install powershell-core

# Windows Terminal
choco install microsoft-windows-terminal

# Set PowerShell Core as the default profile in Windows Terminal
$settingsPath = Get-ChildItem -Recurse -path "$env:localappdata/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json"
$settings = $settingsPath | Get-Content | ConvertFrom-Json

$settings.defaultProfile = "{574e775e-4f2a-5b96-ac1e-a2962a402336}"

$settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath

# 'go-shell' PowerShell module
Copy-Item .\Go-Shell\go.psm1 $env:HOMEPATH\Documents\PowerShell\modules

# Posh-git PowerShell module
Install-Module posh-git

# Copy PowerShell profile that supports shorten-path
Copy-Item .\Microsoft.PowerShell_profile.ps1 $env:HOMEPATH\Documents\PowerShell