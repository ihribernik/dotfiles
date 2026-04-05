$ErrorActionPreference = "Stop"

$script:DotfilesBackupRoot = if ($env:DOTFILES_BACKUP_ROOT) {
    $env:DOTFILES_BACKUP_ROOT
}
else {
    Join-Path $HOME ".dotfiles-backups"
}

$script:DotfilesRunTimestamp = if ($env:DOTFILES_RUN_TIMESTAMP) {
    $env:DOTFILES_RUN_TIMESTAMP
}
else {
    [DateTime]::UtcNow.ToString("yyyyMMddTHHmmssZ")
}

function Write-DotfilesLog {
    param([string]$Message)
    Write-Host "[dotfiles] $Message"
}

function Assert-DotfilesCommand {
    param([string]$Command)

    if (-not (Get-Command $Command -ErrorAction SilentlyContinue)) {
        throw "Required command not found: $Command"
    }
}

function Ensure-DotfilesDirectory {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

function Get-DotfilesBackupDirectory {
    $backupDir = Join-Path $script:DotfilesBackupRoot $script:DotfilesRunTimestamp
    Ensure-DotfilesDirectory -Path $backupDir
    return $backupDir
}

function Test-DotfilesPathPresent {
    param([string]$Path)

    if (Test-Path -LiteralPath $Path) {
        return $true
    }

    return $null -ne (Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue)
}

function Test-DotfilesSymlink {
    param(
        [string]$Path,
        [string]$ExpectedTarget
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return $false
    }

    $item = Get-Item -LiteralPath $Path -Force
    if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -eq 0) {
        return $false
    }

    return $item.Target -eq $ExpectedTarget
}

function Backup-DotfilesTarget {
    param([string]$Target)

    if (-not (Test-DotfilesPathPresent -Path $Target)) {
        return
    }

    $backupDir = Get-DotfilesBackupDirectory
    $sanitized = $Target -replace '^([A-Za-z]):', '$1_'
    $sanitized = $sanitized.TrimStart('\', '/')
    $destination = Join-Path $backupDir $sanitized
    $parent = Split-Path -Parent $destination

    Ensure-DotfilesDirectory -Path $parent
    Move-Item -LiteralPath $Target -Destination $destination
    Write-DotfilesLog "Backed up $Target to $destination"
}

function New-DotfilesManagedItem {
    param(
        [string]$Source,
        [string]$Target
    )

    try {
        New-Item -ItemType SymbolicLink -Path $Target -Target $Source -Force | Out-Null
    }
    catch {
        $sourceItem = Get-Item -LiteralPath $Source -Force
        if ($sourceItem.PSIsContainer) {
            Copy-Item -LiteralPath $Source -Destination $Target -Recurse -Force
        }
        else {
            Copy-Item -LiteralPath $Source -Destination $Target -Force
        }
        Write-DotfilesLog "Copied $Target from $Source because symlink creation failed"
        return
    }

    Write-DotfilesLog "Linked $Target -> $Source"
}

function Install-DotfilesLink {
    param(
        [string]$Source,
        [string]$Target
    )

    if (-not (Test-Path -LiteralPath $Source)) {
        throw "Source does not exist: $Source"
    }

    $parent = Split-Path -Parent $Target
    if ($parent) {
        Ensure-DotfilesDirectory -Path $parent
    }

    if (Test-DotfilesSymlink -Path $Target -ExpectedTarget $Source) {
        Write-DotfilesLog "Already linked: $Target"
        return
    }

    if (Test-DotfilesPathPresent -Path $Target) {
        Backup-DotfilesTarget -Target $Target
    }

    New-DotfilesManagedItem -Source $Source -Target $Target
}
