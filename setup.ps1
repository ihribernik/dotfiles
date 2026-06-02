param(
    [switch]$IncludeOptional,
    [switch]$SkipPackages,
    [switch]$SkipInstall
)

$ErrorActionPreference = "Stop"

$BaseDir = $PSScriptRoot

if (-not $SkipPackages) {
    & (Join-Path $BaseDir "scripts/windows/install-packages.ps1")
}

if (-not $SkipInstall) {
    $installArgs = @()
    if ($IncludeOptional) {
        $installArgs += "-IncludeOptional"
    }

    & (Join-Path $BaseDir "install.ps1") @installArgs
}
