@echo off
REM Run Project Hyperion if already built.
setlocal
set ROOT=%~dp0
set EXE=%ROOT%build\Debug\ProjectHyperion.exe
if exist "%EXE%" (
    echo Executando ProjectHyperion...
    start "Project Hyperion" "%EXE%"
) else (
    echo [ERRO] Executavel nao encontrado. Compile antes usando build_and_run.bat
)
endlocal
