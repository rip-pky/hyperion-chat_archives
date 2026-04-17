@echo off
setlocal enabledelayedexpansion

set "PROJECT_ROOT=%~dp0"
set "SYSTEM_TOOLS=C:\tools"
set "LOCAL_TOOLS=%PROJECT_ROOT%tools"
set "LOG_DIR=%PROJECT_ROOT%logs"
set "LOG_FILE=%LOG_DIR%\wizard_install.log"

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"
(
    echo [%date% %time%] Iniciando wizard_install.bat
) >> "%LOG_FILE%"

echo =====================================================
echo Project Hyperion Wizard Install
echo =====================================================

echo Tentando usar C:\tools...
if not exist "%SYSTEM_TOOLS%" (
    mkdir "%SYSTEM_TOOLS%" 2>nul
)

set "DEST=%SYSTEM_TOOLS%"
if exist "%SYSTEM_TOOLS%" (
    echo Verificando permissoes em %SYSTEM_TOOLS%...
    echo [%date% %time%] Verificando permissoes em %SYSTEM_TOOLS% >> "%LOG_FILE%"
    echo > "%SYSTEM_TOOLS%\.write_test" 2>nul
    if errorlevel 1 (
        set "DEST=%LOCAL_TOOLS%"
        echo [%date% %time%] Falha de permissao em %SYSTEM_TOOLS%, usando %LOCAL_TOOLS% >> "%LOG_FILE%"
    ) else (
        del "%SYSTEM_TOOLS%\.write_test" >nul 2>&1
        echo [%date% %time%] Permissao em %SYSTEM_TOOLS% valida >> "%LOG_FILE%"
    )
) else (
    set "DEST=%LOCAL_TOOLS%"
    echo [%date% %time%] Diretório %SYSTEM_TOOLS% inexistente, usando %LOCAL_TOOLS% >> "%LOG_FILE%"
)

if not exist "%DEST%" mkdir "%DEST%"

echo Instalando arquivos em: %DEST%
echo [%date% %time%] Destino de instalação: %DEST% >> "%LOG_FILE%"
set /p "CHOICE=Quer baixar o ninja automaticamente? [s/N]: "
if /i "%CHOICE%"=="s" (
    set "NINJA_URL=https://github.com/ninja-build/ninja/releases/download/v1.11.1/ninja-win.zip"
    set "TEMP_ZIP=%TEMP%\ninja-win.zip"
    echo Baixando Ninja para %TEMP_ZIP%...
    powershell -NoProfile -Command "try { Invoke-WebRequest -Uri '%NINJA_URL%' -OutFile '%TEMP_ZIP%' -UseBasicParsing } catch { exit 1 }"
    if errorlevel 1 (
        echo [ERRO] Falha ao baixar Ninja.
        echo [%date% %time%] Falha ao baixar Ninja >> "%LOG_FILE%"
        pause
        exit /b 1
    )
    powershell -NoProfile -Command "Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('%TEMP_ZIP%', '%DEST%')"
    if errorlevel 1 (
        echo [ERRO] Falha ao extrair Ninja.
        echo [%date% %time%] Falha ao extrair Ninja >> "%LOG_FILE%"
        pause
        exit /b 1
    )
    del "%TEMP_ZIP%" >nul 2>&1
    echo Ninja instalado em %DEST%\ninja.exe
    echo [%date% %time%] Ninja instalado em %DEST%\ninja.exe >> "%LOG_FILE%"
) else (
    echo Pulei o download. Copie ninja.exe manualmente para %DEST%\ninja.exe
    echo [%date% %time%] Download do Ninja pulado pelo usuario >> "%LOG_FILE%"
)

echo.
if exist "%DEST%\ninja.exe" (
    echo ninja.exe foi instalado com sucesso em %DEST%.
    echo [%date% %time%] ninja.exe encontrado em %DEST% >> "%LOG_FILE%"
) else (
    echo [AVISO] ninja.exe nao foi encontrado em %DEST%.
    echo [%date% %time%] ninja.exe nao encontrado em %DEST% >> "%LOG_FILE%"
)

echo.
echo Pronto. Para compilar, use build_and_run.bat ou build_and_run.ps1.
echo.
set /p "OPENLOGS=Deseja abrir os logs no Notepad? [s/N]: "
if /i "%OPENLOGS%"=="s" (
    notepad "%LOG_FILE%"
)
pause
endlocal
