# Wizard de instalação do Project Hyperion
# Este script instala ninja em C:\tools se possível, ou em tools\ no projeto, sem solicitar elevação.

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$systemTools = 'C:\tools'
$localTools = Join-Path $projectRoot 'tools'
$logDir = Join-Path $projectRoot 'logs'
$logFile = Join-Path $logDir 'wizard_install.log'

if (-Not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $line = "[$timestamp] $Message"
    Add-Content -Path $logFile -Value $line
    Write-Host $Message
}

function Test-WritableDirectory {
    param([string]$Path)
    try {
        if (-Not (Test-Path $Path)) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
        }
        $testFile = Join-Path $Path ([Guid]::NewGuid().ToString() + '.tmp')
        Set-Content -Path $testFile -Value 'test' -Force
        Remove-Item -Path $testFile -Force
        return $true
    } catch {
        return $false
    }
}

Write-Host "==============================================="
Write-Host "Wizard de instalação do Project Hyperion"
Write-Host "==============================================="
Write-Log "Iniciando wizard_install.ps1"

$destInstall = $null
if (Test-WritableDirectory -Path $systemTools) {
    Write-Log "C:\tools está acessível e gravável. Usando esse caminho."
    $destInstall = $systemTools
} else {
    Write-Log "Não é possível usar C:\tools sem privilégios de administrador."
    Write-Log "Será usado o diretório local do projeto: $localTools"
    if (-Not (Test-Path $localTools)) {
        New-Item -ItemType Directory -Path $localTools -Force | Out-Null
    }
    $destInstall = $localTools
}

Write-Log "Destino de instalação: $destInstall"

$doDownload = Read-Host "Quer baixar o Ninja automaticamente? (s/n)"
if ($doDownload -match '^[sS]') {
    $ninjaUrl = 'https://github.com/ninja-build/ninja/releases/download/v1.11.1/ninja-win.zip'
    $tempZip = Join-Path $env:TEMP 'ninja-win.zip'
    Write-Log "Baixando Ninja..."
    try {
        Invoke-WebRequest -Uri $ninjaUrl -OutFile $tempZip -UseBasicParsing -ErrorAction Stop
    } catch {
        Write-Log "Falha ao baixar Ninja: $_"
        Write-Error "Falha ao baixar Ninja: $_"
        exit 1
    }

    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem | Out-Null
        [System.IO.Compression.ZipFile]::ExtractToDirectory($tempZip, $destInstall)
    } catch {
        Write-Log "Falha ao extrair Ninja: $_"
        Write-Error "Falha ao extrair Ninja: $_"
        exit 1
    }

    Remove-Item -Path $tempZip -Force
    Write-Log "Ninja instalado em $destInstall\ninja.exe"
    Write-Host "Ninja instalado em $destInstall\ninja.exe"
} else {
    Write-Log "Pulando download automático."
    Write-Host "Pulando download automático. Copie ninja.exe manualmente para $destInstall."
}

if (-Not (Test-Path (Join-Path $destInstall 'ninja.exe'))) {
    Write-Log "ninja.exe não foi encontrado em $destInstall. Instale manualmente se necessário."
    Write-Warning "ninja.exe não foi encontrado em $destInstall. Instale manualmente se necessário."
} else {
    Write-Log "ninja.exe pronto em $destInstall\ninja.exe"
    Write-Host "ninja.exe pronto em $destInstall\ninja.exe"
}

Write-Host ""
Write-Host "Se quiser usar ninja sem especificar o caminho, adicione esse diretório ao PATH de usuário:"
Write-Host $destInstall
Write-Host ""
Write-Host "Instalação concluída. Rode build_and_run.bat ou build_and_run.ps1 para compilar."

$openLog = Read-Host "Deseja abrir os logs no Notepad? (s/n)"
if ($openLog -match '^[sS]') {
    Start-Process notepad.exe $logFile
}
