$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$projectRoot = Resolve-Path "$scriptRoot\.."
$buildDir = Join-Path $projectRoot 'build'
$installer = Join-Path $scriptRoot 'HyperionInstaller.nsi'

Write-Host 'Compilando Project Hyperion para Windows...'
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
cmake --preset debug | Out-Null
cmake --build --preset debug | Out-Null

if (-Not (Test-Path "$buildDir\Debug\ProjectHyperion.exe")) {
    Write-Error 'Executável não encontrado. Verifique a compilação.'
    exit 1
}

Write-Host 'Gerando instalador NSIS...'
if (-Not (Get-Command makensis -ErrorAction SilentlyContinue)) {
    Write-Error 'makensis não encontrado. Instale NSIS e tente novamente.'
    exit 1
}

Push-Location $scriptRoot
makensis HyperionInstaller.nsi
Pop-Location

Write-Host 'Instalador criado em:'
Write-Host (Join-Path $scriptRoot 'HyperionInstaller.exe')
