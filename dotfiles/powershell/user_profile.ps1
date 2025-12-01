# Utilities
function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}


function touch() {
    $fileName = $args[0]
    # Comprobar si el archivo existe
    if (-not(Test-Path $fileName)) {
        # Si no existe, crealo
        New-Item -ItemType File -Name $fileName
    }
    else {
        #Si existe, actualiza el timestamp
        (Get-ChildItem $fileName).LastWriteTime = Get-Date
    }
}

function use-debug() {
    New-Item -Path Env:\DEBUG -Value '1'
}

function clear-history(){
    Write-Output "" > (Get-PSReadlineOption).HistorySavePath
}

$IsInteractiveSession = ($Host.Name -eq 'ConsoleHost') -and
    -not ([Environment]::GetCommandLineArgs() -contains '-Command')

if ($IsInteractiveSession) {
    # Prompt
    if (Get-Command git -ErrorAction SilentlyContinue) {
        Import-Module posh-git -ErrorAction SilentlyContinue
    }

    if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
        oh-my-posh init pwsh --config "space" | Invoke-Expression
    }

    # Icons
    if (Get-Module -ListAvailable Terminal-Icons) {
        Import-Module -Name Terminal-Icons -ErrorAction SilentlyContinue
    }

    if (Get-Module -ListAvailable PSFzf) {
        Import-Module PSFzf -ErrorAction SilentlyContinue
        Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
    }

    if (Get-Module -ListAvailable Microsoft.WinGet.CommandNotFound) {
        Import-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue
    }

}

