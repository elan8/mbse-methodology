param(
    [string]$Spec42Exe = "",
    [ValidateSet("text", "json", "sarif", "junit")]
    [string]$Format = "text"
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$domainLibs = Join-Path $repoRoot "..\sysml-domain-libraries"

if (-not $Spec42Exe) {
    if ($env:SPEC42_EXE) {
        $Spec42Exe = $env:SPEC42_EXE
    } elseif (Test-Path "C:\Git\elan8\spec42\target\debug\spec42.exe") {
        $Spec42Exe = "C:\Git\elan8\spec42\target\debug\spec42.exe"
    } elseif (Test-Path "C:\Git\spec42\target\debug\spec42.exe") {
        $Spec42Exe = "C:\Git\spec42\target\debug\spec42.exe"
    } else {
        $Spec42Exe = "spec42"
    }
}

$arguments = @(
    "--disable-kpar-library", "domain",
    "--disable-kpar-library", "method",
    "--library-path", (Join-Path $repoRoot "library")
)

if (Test-Path $domainLibs) {
    $arguments += @(
        "--library-path", (Join-Path (Resolve-Path $domainLibs) "domain"),
        "--library-path", (Join-Path (Resolve-Path $domainLibs) "technical"),
        "--library-path", (Join-Path (Resolve-Path $domainLibs) "generic")
    )
}

$arguments += @(
    "check", $repoRoot,
    "--workspace-root", $repoRoot,
    "--format", $Format
)

& $Spec42Exe @arguments
exit $LASTEXITCODE
