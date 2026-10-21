param(
    [Parameter(Mandatory = $true)][string]$Spec42,
    [Parameter(Mandatory = $true)][string]$StdlibPath,
    [string]$DomainLibraryPath
)
$ErrorActionPreference = 'Stop'
$methodRoot = Split-Path $PSScriptRoot -Parent
. (Join-Path $PSScriptRoot 'source_digest.ps1')
$lock = Get-Content -LiteralPath (Join-Path $methodRoot 'dependencies.lock.json') -Raw | ConvertFrom-Json
$actualVersion = (& $Spec42 --version).Trim()
if ($LASTEXITCODE -ne 0 -or $actualVersion -ne "spec42 $($lock.spec42.version)") {
    throw "Expected Spec42 $($lock.spec42.version); found $actualVersion"
}
if ((Get-ModelSourceDigest -Path $StdlibPath) -ne $lock.standardLibrary.sourceTreeSha256) {
    throw 'Standard-library sources differ from the tested baseline in dependencies.lock.json.'
}
if ($DomainLibraryPath) {
    if (-not (Test-Path -LiteralPath $DomainLibraryPath)) { throw 'Domain-library override does not exist.' }
    Write-Host 'Using explicit domain-library override; the frozen artifact is bypassed.'
    (Resolve-Path -LiteralPath $DomainLibraryPath).Path
    return
}
$archive = Join-Path $methodRoot $lock.domainLibrary.artifact
if ((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant() -ne $lock.domainLibrary.sha256) {
    throw 'Domain-library archive checksum differs from dependencies.lock.json.'
}
$destination = Join-Path $methodRoot ".cache/dependencies/$($lock.domainLibrary.sha256)"
if (-not (Test-Path -LiteralPath $destination)) {
    & $Spec42 --disable-kpar-library domain --disable-kpar-library method --stdlib-path $StdlibPath `
        unbundle $archive --directory $destination | ForEach-Object { Write-Host $_ }
    if ($LASTEXITCODE -ne 0) { throw 'Could not validate/unpack the frozen domain library.' }
}
$modelRoot = Join-Path $destination 'model'
if ((Get-ModelSourceDigest -Path $modelRoot -ExcludeExamples) -ne $lock.domainLibrary.sourceTreeSha256) {
    throw 'Cached domain-library sources differ from the frozen artifact. Use a fresh cache directory.'
}
$modelRoot
