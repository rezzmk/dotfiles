Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

$scriptsFolder = "\scripts"

$bootstrapScript = "$scriptsFolder\bootstrap.ps1"
Write-Host "Running $bootstrapScript..." -ForegroundColor Blue

& ".\$bootstrapScript"

LogBlue "Calling Import-Module utilities..."
Import-Module "utilities" -Force
LogGreen "  Import OK`n"

# Check if running as administrator
LogBlue "Admin check"
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  LogRed "  Please run the script as Administrator!"
  return
}
else {
  LogGreen "  OK!"
}

LogBlue "`nChocolatey check"
if (-not (IsInstalled "choco")) {
  LogYellow "  Not found, Installing..."
  Set-ExecutionPolicy Bypass -Scope Process -Force; 
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
  iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  LogGreen "  Installed"
}
else {
  LogGreen "  Already installed"
}

LogBlue "`nGit check"
if (-not (IsInstalled "git")) {
  LogYelloy "  Not found, installing..."
  choco install git -y
  LogGree "  Installed"
}
else {
  LogGreen "  Already installed"
}

$gitConfigScript = "$scriptsFolder\git-config.ps1"
LogBlue "`nGit Configuration ($gitConfigScript)"
& ".\$gitConfigScript"
LogGreen "  Done"

LogBlue "`nHostname configuration"
$hostname = "rezzmk"
$currentHostName = (Get-WmiObject -Class Win32_ComputerSystem).Name
if ($currentHostname -ne $hostname) {
  Rename-Computer -NewName $hostname
  LogGreen "  Hostname updated to $hostname"
}
else {
  LogYellow "  Hostname not updated because it is already set to $hostname"
}

LogBlue "`nSymlinking configurations"

LogYellow "  /common/config/ -> ~/.config/"
CreateSymLinks "..\common\config" "$env:userprofile\.config" $true

LogYellow "`n  /common/ -> ~/"
CreateSymLinks "..\common" "$env:userprofile" $false

LogYellow "`n  /config/ -> ~/.config/"
CreateSymLinks "config" "$env:userprofile" $true

LogYellow "`n  / -> ~/"
CreateSymLinks "." "$env:userprofile\.config" $false

LogYellow "`n  /Documents -> ~/Documents/"
CreateSymLinks "Documents" "$env:userprofile\Documents" $true

LogBlue "`n-- Finished. You should restart your computer for some changes to take effect"
