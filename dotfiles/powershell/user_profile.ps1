# Prompt
Import-Module posh-git
$personalFolder = $ExecutionContext.InvokeCommand.ExpandString('$home\dev\personal\ihribernik_dotfiles\dotfiles\powershell')
$dark_theme = "personal.omp.json"
$light_theme = "personal_light.omp.json"
$themeFile = ""
$currentMode = Get-ItemPropertyValue -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme

if ($currentMode -eq 1) {
    # If currently in Light Mode
    $themeFile = $light_theme
}
else {
    # If currently in Dark Mode
    $themeFile = $dark_theme
}


$theme = Join-Path $personalFolder $themeFile
oh-my-posh init pwsh --config $theme | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons

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