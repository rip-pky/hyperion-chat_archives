@echo off
setlocal
set OUTPUT=%~dp0project_hyperion_legacy_mod.zip
if exist "%OUTPUT%" del /Q "%OUTPUT%"
powershell -Command "Compress-Archive -Path (Resolve-Path '%~dp0..\legacy_web').Path, (Resolve-Path '%~dp0..\docs\markdown').Path -DestinationPath '%OUTPUT%' -Force"
echo Pacote criado: %OUTPUT%
endlocal
