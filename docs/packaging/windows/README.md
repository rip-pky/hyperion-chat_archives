# Packaging Windows

Este diretório contém scripts para criar o instalador Windows do Project Hyperion.

## Conteúdo

- `HyperionInstaller.nsi`: script NSIS para gerar um instalador Windows.
- `build_installer.ps1`: script PowerShell para gerar o build e chamar o instalador.

## Requisitos

- `cmake` disponível no PATH.
- `ninja` ou outro gerador CMake instalado.
- `makensis` para criar o instalador NSIS.
- Qt6 com componentes `Core`, `Gui`, `Widgets`, `Network`, `WebEngineWidgets`, `WebChannel`.

## Uso

1. Compile com o preset debug ou release:
   ```powershell
   cmake --preset debug
   cmake --build --preset debug
   ```
2. Gere o instalador:
   ```powershell
   .\packaging\windows\build_installer.ps1
   ```

## Produto final

- `Hyperion.exe`: executável do app.
- `HyperionInstaller.exe`: instalador NSIS.
