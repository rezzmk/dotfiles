#Requires -RunAsAdministrator

param (
	[switch]$chocoinstallapps,
	[switch]$wintermplugins,
	[switch]$nerdfonts,
	[switch]$configuregit,
	[switch]$configurewindows,
	[switch]$configurewindowsexplorer,
	[switch]$installwsl2,
	[switch]$noremap,
)

Import-Module utilities

[Boolean]$force = $false
if ($PSBoundParameters.Count -eq 0) {
	$force = $true;
}

if ($noremap -eq $false) {
	# Setup AutoHotKey scripts
	$StartupFolder = [environment]::getfolderpath("Startup")
	Copy-Item "scripts/run-remap-capslock-asadmin.vbs" $StartupFolder
}

if ($chocoinstallapps -or $force) {
	Write-Host "Installing Chocolatey..." -ForegroundColor Yellow 
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
	Write-Host "Done" -ForegroundColor Green

	ReloadPath

	Write-Host "Installing chocolatey applications..." -ForegroundColor Yellow
	.("$PSScriptRoot\scripts\choco_install_apps.ps1")
}

if ($wintermplugins -or $force) {
    Write-Host "Installing windows terminal modules..." -ForegroundColor Yellow
	.("$PSScriptRoot\scripts\windows-terminal-modules.ps1")

	ReloadPath
}

if ($configuregit -or $force) {
	Write-Host "Configuring git..."
	.("$PSScriptRoot\config\git-config.ps1")

	ReloadPath
}

if ($configurewindows -or $force) {
	Write-Host "Configuring windows..."
	.("$PSScriptRoot\config\windows-config.ps1")

	ReloadPath
}

if ($nerdfonts -or $force -or (-Not (Test-Path -Path "nerd-fonts"))) {
	Write-Host "Installing nerd-fonts... This WILL take a while..." -ForegroundColor Yellow

	git clone https://github.com/rezzmk/nerd-fonts.git
	Set-Location nerd-fonts
	.\install.ps1
	Set-Location ..\
}

if ($configurewindowsexplorer -or $force) {
	Write-Host "Configuring windows explorer..." -ForegroundColor Yellow
	.("$PSScriptRoot\config\windows-explorer-config.ps1")

	ReloadPath
}

if ($installwsl2 -or $force) {
	Write-Host "Installing WSL 2" -ForegroundColor Yellow

	wsl --install
}
