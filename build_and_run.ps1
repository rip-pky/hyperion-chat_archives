# Build and run Project Hyperion on Windows
# Requisitos: CMake, Qt6 (incluindo Qt6::Core, Qt6::Gui, Qt6::Widgets, Qt6::Network)

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location -Path $projectRoot

if (-Not (Get-Command cmake -ErrorAction SilentlyContinue)) {
    Write-Error "CMake não está instalado ou não está no PATH. Instale CMake e tente novamente."
    exit 1
}

$ninjaPathLocal = Join-Path $projectRoot 'tools\ninja.exe'
if (Test-Path $ninjaPathLocal) {
    $env:PATH = "$projectRoot\tools;$env:PATH"
    Write-Host 'Ninja encontrado em tools\ e adicionado ao PATH temporariamente.'
} elseif (-Not (Get-Command ninja -ErrorAction SilentlyContinue)) {
    $ninjaPath = 'C:\tools\ninja.exe'
    if (Test-Path $ninjaPath) {
        $env:PATH = "C:\tools;$env:PATH"
        Write-Host 'Ninja encontrado em C:\tools e adicionado ao PATH temporariamente.'
    } else {
        Write-Warning 'Ninja não encontrado. Coloque ninja.exe em tools\ ou em C:\tools.'
    }
}

$buildDir = Join-Path $projectRoot 'build'
if (-Not (Test-Path $buildDir)) {
    New-Item -ItemType Directory -Path $buildDir | Out-Null
}

cmake --preset debug
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

cmake --build --preset debug
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

$exePath = Join-Path $buildDir 'Debug\ProjectHyperion.exe'
if (Test-Path $exePath) {
    Write-Host "Executando ProjectHyperion..."
    Start-Process -FilePath $exePath -WorkingDirectory $projectRoot
} else {
    Write-Error "Executável não encontrado: $exePath"
    exit 1
}
