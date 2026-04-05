param(
    [switch]$IncludeOptional
)

$ErrorActionPreference = "Stop"

$BaseDir = $PSScriptRoot
. (Join-Path $BaseDir "scripts/common/helpers.ps1")

Write-DotfilesLog "Installing core dotfiles from $BaseDir"

$coreDirs = @(
    (Join-Path $HOME "dev/personal"),
    (Join-Path $HOME "dev/work"),
    (Join-Path $HOME ".config"),
    (Join-Path $HOME ".config/powershell")
)

foreach ($dir in $coreDirs) {
    Ensure-DotfilesDirectory -Path $dir
}

Install-DotfilesLink -Source (Join-Path $BaseDir "dotfiles/git/.gitconfig") -Target (Join-Path $HOME ".gitconfig")
Install-DotfilesLink -Source (Join-Path $BaseDir "dotfiles/git/.gitconfig_work") -Target (Join-Path $HOME ".gitconfig_work")
Install-DotfilesLink -Source (Join-Path $BaseDir "dotfiles/.editorconfig") -Target (Join-Path $HOME ".editorconfig")
Install-DotfilesLink -Source (Join-Path $BaseDir "dotfiles/.wezterm.lua") -Target (Join-Path $HOME ".wezterm.lua")
Install-DotfilesLink -Source (Join-Path $BaseDir "dotfiles/nvim") -Target (Join-Path $HOME ".config/nvim")
Install-DotfilesLink -Source (Join-Path $BaseDir "dotfiles/powershell/user_profile.ps1") -Target (Join-Path $HOME ".config/powershell/user_profile.ps1")
Install-DotfilesLink -Source (Join-Path $BaseDir "dotfiles/powershell/Microsoft.PowerShell_profile.ps1") -Target (Join-Path $HOME "Documents/PowerShell/Microsoft.PowerShell_profile.ps1")
Install-DotfilesLink -Source (Join-Path $BaseDir "dotfiles/windows-terminal/settings.json") -Target (Join-Path $HOME "AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json")

if ($IncludeOptional) {
    Write-DotfilesLog "Installing optional configs"
    Install-DotfilesLink -Source (Join-Path $BaseDir "dotfiles/User") -Target (Join-Path $HOME "AppData/Roaming/Sublime Text 3/Packages/User")
}
else {
    Write-DotfilesLog "Skipping optional configs. Use -IncludeOptional to install them."
}

Write-DotfilesLog "Install complete"
