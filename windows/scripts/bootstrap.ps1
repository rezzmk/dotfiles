$ModulesPath = "$HOME\Documents\PowerShell\Modules"

function LoadUtilities {
  New-Item -ItemType Directory -Force -Path $ModulesPath\utilities | Out-Null
  Copy-Item $PSScriptRoot\..\modules\exports.psm1 -Destination $ModulesPath\utilities\utilities.psm1 -Force | Out-Null

  New-ModuleManifest -Path $ModulesPath\utilities\utilities.psd1 -RootModule $ModulesPath\utilities\utilities.psm1
}
LoadUtilities
