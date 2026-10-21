param(
    [Parameter(Mandatory = $true)]
    [string]$Spec42,
    [Parameter(Mandatory = $true)]
    [string]$StdlibPath,
    [string]$DomainLibraryPath,
    [string]$ModelPath
)
$ErrorActionPreference = 'Stop'
$methodRoot = Split-Path $PSScriptRoot -Parent
$DomainLibraryPath = & (Join-Path $PSScriptRoot 'prepare_dependencies.ps1') `
    -Spec42 $Spec42 -StdlibPath $StdlibPath -DomainLibraryPath $DomainLibraryPath
$libraryArgs = @('--disable-kpar-library', 'domain', '--disable-kpar-library', 'method')
$libraryArgs += @('--library-path', $DomainLibraryPath)
if ($StdlibPath) { $libraryArgs += @('--stdlib-path', $StdlibPath) }
$workspaces = @(
    'templates/project-template/model',
    'examples/elevator/model',
    'examples/tooling-rules/model'
)
if ($ModelPath) { $workspaces = @((Resolve-Path -LiteralPath $ModelPath).Path) }
foreach ($workspace in $workspaces) {
    $modelPath = if ([IO.Path]::IsPathRooted($workspace)) { $workspace } else { Join-Path $methodRoot $workspace }
    Write-Host "Checking $workspace"
    & $Spec42 @libraryArgs check $modelPath --workspace-root $modelPath
    if ($LASTEXITCODE -ne 0) { throw "Model check failed for $workspace (exit $LASTEXITCODE)" }
}
