# Prompt
Import-Module posh-git
$personalFolder = $ExecutionContext.InvokeCommand.ExpandString('$home\powershell')
$themesFolder = $ExecutionContext.InvokeCommand.ExpandString('$home\AppData\Local\Programs\oh-my-posh\themes')
$themeFile = "gruvbox.omp.json"
$theme = Join-Path $themesFolder $themeFile
oh-my-posh init pwsh --config $theme | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons

# Utilities
function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}


function Touch-File() {
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

function use-debug(){
    New-Item -Path Env:\DEBUG -Value '1'
}

### Creando un alias para touch

# Checar si el alias touch existe
if (-not(Test-Path -Path Alias:Touch)) {
    New-Alias -Name Touch Touch-File -Force
}