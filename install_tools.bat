@echo off
setlocal

set "TOOLPATH=C:\tools"
set "SELF=%~f0"

echo =====================================================
echo Project Hyperion Tool Installer
echo =====================================================

echo Verificando se o script esta rodando como administrador...
net session >nul 2>&1
if errorlevel 1 (
    echo.
    echo O script precisa de privilegios de administrador.
    echo Solicitando elevacao...
    powershell -Command "Start-Process '%COMSPEC%' -ArgumentList '/c','"%SELF%"' -Verb RunAs" >nul 2>&1
    exit /b
)

echo.
echo Criando pasta %TOOLPATH% se ainda nao existir...
if not exist "%TOOLPATH%" (
    mkdir "%TOOLPATH%"
    if errorlevel 1 (
        echo [ERRO] Falha ao criar %TOOLPATH%.
        pause
        exit /b 1
    )
)

echo.
echo Para instalar o Ninja, voce pode copiar um ninja.exe existente ou pular esta etapa.
set /p "NINJAPATH=Digite o caminho completo para ninja.exe (ou deixe vazio para pular): "
if not "%NINJAPATH%"=="" (
    if exist "%NINJAPATH%" (
        copy /Y "%NINJAPATH%" "%TOOLPATH%\ninja.exe" >nul
        if errorlevel 1 (
            echo [ERRO] Nao foi possivel copiar ninja.exe.
            pause
            exit /b 1
        )
        echo ninja.exe copiado para %TOOLPATH%.
    ) else (
        echo [AVISO] Arquivo nao encontrado: %NINJAPATH%
    )
) else (
    echo Nao foi fornecido caminho para ninja.exe.
)

echo.
echo Configuracao concluida.
echo Verifique se o Ninja esta em %TOOLPATH%\ninja.exe ou coloque-o manualmente.
echo.
echo Opcional: execute este script novamente depois de copiar ninja.exe em %TOOLPATH%.

pause
endlocal
