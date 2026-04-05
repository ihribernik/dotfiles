$ErrorActionPreference = "Stop"

$BaseDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
. (Join-Path $BaseDir "scripts/common/helpers.ps1")

function Assert-ManagedTarget {
    param(
        [string]$Target,
        [string]$Source
    )

    if (Test-DotfilesSymlink -Path $Target -ExpectedTarget $Source) {
        Write-DotfilesLog "OK $Target"
        return
    }

    if (Test-Path -LiteralPath $Target) {
        Write-DotfilesLog "Present but not linked: $Target"
        return
    }

    throw "Missing managed target: $Target"
}

Assert-ManagedTarget -Target (Join-Path $HOME ".gitconfig") -Source (Join-Path $BaseDir "dotfiles/git/.gitconfig")
Assert-ManagedTarget -Target (Join-Path $HOME ".gitconfig_work") -Source (Join-Path $BaseDir "dotfiles/git/.gitconfig_work")
Assert-ManagedTarget -Target (Join-Path $HOME ".editorconfig") -Source (Join-Path $BaseDir "dotfiles/.editorconfig")
Assert-ManagedTarget -Target (Join-Path $HOME ".config/nvim") -Source (Join-Path $BaseDir "dotfiles/nvim")
Assert-ManagedTarget -Target (Join-Path $HOME ".config/powershell/user_profile.ps1") -Source (Join-Path $BaseDir "dotfiles/powershell/user_profile.ps1")
Assert-ManagedTarget -Target (Join-Path $HOME "Documents/PowerShell/Microsoft.PowerShell_profile.ps1") -Source (Join-Path $BaseDir "dotfiles/powershell/Microsoft.PowerShell_profile.ps1")
Assert-ManagedTarget -Target (Join-Path $HOME "AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json") -Source (Join-Path $BaseDir "dotfiles/windows-terminal/settings.json")

foreach ($dir in @(
    (Join-Path $HOME "dev/personal"),
    (Join-Path $HOME "dev/work"),
    (Join-Path $HOME ".config"),
    (Join-Path $HOME ".config/powershell")
)) {
    if (-not (Test-Path -LiteralPath $dir)) {
        throw "Missing required directory: $dir"
    }
    Write-DotfilesLog "OK $dir"
}

Write-DotfilesLog "Verification complete"
