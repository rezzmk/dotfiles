Push-Location
Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced

Set-ItemProperty . HideFileExt "0"
Set-ItemProperty . Hidden "1"
Set-ItemProperty . NoNetCrawling "1"
Set-ItemProperty . DontPrettyPath "1"
Set-ItemProperty . ShowSuperHidden "1"

Pop-Location
Stop-Process -processName: Explorer -force
