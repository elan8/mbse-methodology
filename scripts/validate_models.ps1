param(
    [Parameter(Mandatory = $true)]
    [string]$Spec42,
    [string]$StdlibPath,
    [string]$DomainLibraryPath
)
$ErrorActionPreference = 'Stop'
$methodRoot = Split-Path $PSScriptRoot -Parent
if (-not $DomainLibraryPath) {
    $DomainLibraryPath = Join-Path (Split-Path $methodRoot -Parent) 'sysml-domain-libraries/model'
}
if (-not (Test-Path -LiteralPath $DomainLibraryPath)) {
    throw 'Domain library not found. Pass -DomainLibraryPath for the pinned Elan8 source or extracted library root.'
}
$libraryArgs = @('--disable-kpar-library', 'domain', '--disable-kpar-library', 'method')
$libraryArgs += @('--library-path', $DomainLibraryPath)
if ($StdlibPath) { $libraryArgs += @('--stdlib-path', $StdlibPath) }
$workspaces = @(
    'templates/project-template/model',
    'examples/elevator/model'
)
foreach ($workspace in $workspaces) {
    $modelPath = Join-Path $methodRoot $workspace
    Write-Host "Checking $workspace"
    & $Spec42 @libraryArgs check $modelPath --workspace-root $modelPath
    if ($LASTEXITCODE -ne 0) { throw "Model check failed for $workspace (exit $LASTEXITCODE)" }
}
