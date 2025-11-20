# Prompt
Import-Module posh-git
oh-my-posh init pwsh --config "space" | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

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

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
