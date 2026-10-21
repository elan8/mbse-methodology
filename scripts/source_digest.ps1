function Get-ModelSourceDigest {
    param([Parameter(Mandatory = $true)][string]$Path, [switch]$ExcludeExamples)
    $rootPath = (Resolve-Path -LiteralPath $Path).Path.TrimEnd([char[]]@('\', '/'))
    [string[]]$relativePaths = @(Get-ChildItem -LiteralPath $rootPath -Recurse -File |
        Where-Object { $_.Extension -in @('.sysml', '.kerml') } |
        ForEach-Object { $_.FullName.Substring($rootPath.Length + 1).Replace('\', '/') } |
        Where-Object { -not $ExcludeExamples -or ($_ -notmatch '(^|/)examples/' -and $_ -ne 'Examples.sysml') })
    [Array]::Sort($relativePaths, [StringComparer]::Ordinal)
    $entries = foreach ($relative in $relativePaths) {
        $hash = (Get-FileHash -LiteralPath (Join-Path $rootPath $relative) -Algorithm SHA256).Hash.ToLowerInvariant()
        "$relative`0$hash"
    }
    $bytes = [Text.Encoding]::UTF8.GetBytes(($entries -join "`n"))
    $algorithm = [Security.Cryptography.SHA256]::Create()
    try { ([BitConverter]::ToString($algorithm.ComputeHash($bytes))).Replace('-', '').ToLowerInvariant() }
    finally { $algorithm.Dispose() }
}
