function ReloadPath {
  Write-Host "Updating path..." -ForegroundColor Blue

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") `
    + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function RunAction {
  param(
      [Parameter(Mandatory=$false, Position=0)]
      [string] $m,

      [Parameter(Mandatory=$true, Position=1)]
      [ScriptBlock] $a
      )

    Write-Host $m -ForegroundColor Red
    $a.Invoke()
    Write-Host "Done" -ForegroundColor Green
    ReloadPath
}

function ChocoInstallApps {
  param(
      [Parameter(Mandatory=$true, Position=0)]
      [string[]] $apps
      )

    foreach ($app in $apps) {
      $res = (choco list -lo | Where-Object { $_.ToLower().StartsWith($app.ToLower()) })
        if ($null -eq $res) {
          Write-Host "Installing $app..." -ForegroundColor Yellow
            & choco install $app --yes --limit-output --log-file choco.log
        }
        else {
          Write-Host "$app already installed!" -ForegroundColor Green
        }
    }
}

function ChocoInstallWinFeatures {
  param(
      [Parameter(Mandatory=$true, Position=0)]
      [string[]] $apps
      )

    foreach ($app in $apps) {
      Write-Host "Installing $app..." -ForegroundColor Yellow
        & choco install $app --yes --source windowsfeatures --log-file choco.log
    }
}


function IsInstalled($appName) {
  $installed = $null
  try {
    $installed = (Get-Command $appName -ErrorAction Stop).Source
  }
  catch {
    $installed = $null
  }

  return $installed
}

function LogRed($message) {
  Write-Host $message -ForegroundColor Red
}

function LogGreen($message) {
  Write-Host $message -ForegroundColor Green
}

function LogYellow($message) {
  Write-Host $message -ForegroundColor Yellow
}

function LogBlue($message) {
  Write-Host $message -ForegroundColor Blue
}

function CreateSymLinks {
  Param (
    [Parameter(Mandatory=$true, Position=0)] [string] $SourceDir,
    [Parameter(Mandatory=$true, Position=1)] [string] $TargetDir,
    [Parameter(Mandatory=$true, Position=2)] [boolean] $Recurse
  )

  $pathExists = Test-Path -Path $sourceDir
  if (!$pathExists) {
    LogGreen "  Nothing to process"
    return;
  }

  $expandedSourceDir = (Resolve-Path $sourceDir).Path

  $filesInSource = Get-ChildItem -Path $SourceDir -File
  if ($Recurse) {
    $filesInSource = Get-ChildItem -Path $SourceDir -File -Recurse
  }

  if ($($filesInSource).Count -eq 0) {
    LogGreen "  Nothing to process"
    return;
  }

  $processedSomething = 0;
  foreach($file in $filesInSource) {
   if ($file.Name -eq "install.ps1") {
    continue;
   }

   $jesusChristPowershell = $file.FullName.Replace($expandedSourceDir, '')
   $target = Join-Path -Path $TargetDir -ChildPath $jesusChristPowershell
   New-Item -ItemType SymbolicLink -Path $target -Target $file.FullName -Force | Out-Null
   LogGreen "  [-] $($file.FullName) -> $target"

   $processedSomething = 1;
  }

  if ($processedSomething -eq 0) {
    LogGreen "  Nothing to process"
  }
}

Export-ModuleMember -Function RunAction
Export-ModuleMember -Function ReloadPath
Export-ModuleMember -Function ChocoInstallApps
Export-ModuleMember -Function ChocoInstallWinFeatures

Export-ModuleMember -Function IsInstalled
Export-ModuleMember -Function CreateSymLinks

Export-ModuleMember -Function LogGreen
Export-ModuleMember -Function LogYellow
Export-ModuleMember -Function LogRed
Export-ModuleMember -Function LogBlue
