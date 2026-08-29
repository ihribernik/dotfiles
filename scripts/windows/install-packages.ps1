$ErrorActionPreference = "Stop"

$BaseDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
. (Join-Path $BaseDir "scripts/common/helpers.ps1")

$wingetPackages = @(
    "Microsoft.Powershell",
    "Microsoft.WindowsTerminal",
    "Git.Git",
    "JanDeDobbeleer.OhMyPosh",
    "BurntSushi.ripgrep.MSVC",
    "junegunn.fzf",
    "GitHub.cli",
    "sharkdp.bat",
    "jqlang.jq",
    "LLVM.LLVM",
    "sharkdp.fd",
    "Neovim.Neovim",
    "lsd-rs.lsd",
    "wez.wezterm",
    "ezwinports.make",
    "Kitware.CMake"
)

Assert-DotfilesCommand -Command "winget"

foreach ($package in $wingetPackages) {
    Write-DotfilesLog "Ensuring package $package"
    & winget install --id $package --exact --source winget --silent --ignore-warnings --accept-package-agreements --accept-source-agreements | Out-Null
}

$modules = @(
    "posh-git",
    "PSFzf",
    "Terminal-Icons",
    "Microsoft.WinGet.CommandNotFound"
)

if (Get-Command Set-PSRepository -ErrorAction SilentlyContinue) {
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

foreach ($module in $modules) {
    if (-not (Get-Module -ListAvailable -Name $module)) {
        Write-DotfilesLog "Installing PowerShell module $module"
        Install-Module -Name $module -Repository PSGallery -Scope CurrentUser -Force -AllowClobber
    }
}

Write-DotfilesLog "Package install complete"
