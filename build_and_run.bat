@echo off
REM Build and run Project Hyperion on Windows.
REM Requires CMake installed and available in PATH.

setlocal
set ROOT=%~dp0
set BUILD_DIR=%ROOT%build

if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

where cmake >nul 2>&1
if errorlevel 1 (
    echo [ERRO] O comando CMake nao foi encontrado no PATH.
    echo Instale CMake e adicione ao PATH ou execute o script em um terminal com CMake.
    pause
    exit /b 1
)

if exist "%~dp0tools\ninja.exe" (
    set "PATH=%~dp0tools;%PATH%"
    echo Ninja encontrado em %~dp0tools e adicionado ao PATH.
) else (
    where ninja >nul 2>&1
    if errorlevel 1 (
        if exist "C:\tools\ninja.exe" (
            set "PATH=C:\tools;%PATH%"
            echo Ninja encontrado em C:\tools e adicionado ao PATH.
        ) else (
            echo [AVISO] Ninja nao encontrado. Coloque ninja.exe em %~dp0tools ou em C:\tools.
        )
    )
)

cd /d "%BUILD_DIR%"
cmake --preset debug
if errorlevel 1 (
    echo [ERRO] CMake configuracao falhou. Verifique se o Ninja esta instalado e disponivel no PATH.
    pause
    exit /b 1
)

cmake --build --preset debug
if errorlevel 1 (
    echo [ERRO] Compilacao falhou.
    pause
    exit /b 1
)

set EXE=%BUILD_DIR%\Debug\ProjectHyperion.exe
if exist "%EXE%" (
    echo Executando ProjectHyperion...
    start "Project Hyperion" "%EXE%"
) else (
    echo [ERRO] Executavel nao encontrado: %EXE%
    pause
    exit /b 1
)
endlocal
