param([Parameter(Mandatory = $true)][string]$Path)
$ErrorActionPreference = 'Stop'
$methodRoot = Split-Path $PSScriptRoot -Parent
$destination = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
if (Test-Path -LiteralPath $destination) { throw 'Choose a new project directory; existing paths are never overwritten.' }
[IO.Directory]::CreateDirectory([IO.Path]::GetDirectoryName($destination)) | Out-Null
Copy-Item -LiteralPath (Join-Path $methodRoot 'templates/project-template') -Destination $destination -Recurse
foreach ($file in @('dependencies.lock.json', '.spec42-version', '.gitignore')) {
    Copy-Item -LiteralPath (Join-Path $methodRoot $file) -Destination $destination
}
Copy-Item -LiteralPath (Join-Path $methodRoot 'libraries') -Destination $destination -Recurse
$scriptDestination = Join-Path $destination 'scripts'
New-Item -ItemType Directory -Path $scriptDestination | Out-Null
foreach ($file in @('prepare_dependencies.ps1', 'source_digest.ps1', 'validate_models.ps1', 'check_structure.py')) {
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot $file) -Destination $scriptDestination
}
Write-Host "Created $destination with the frozen dependency and validation tools."
Write-Host 'Validate with scripts/validate_models.ps1 -ModelPath ./model -Spec42 <exe> -StdlibPath <stdlib>'
