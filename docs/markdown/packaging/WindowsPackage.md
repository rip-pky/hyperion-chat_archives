# Packaging Windows

Este documento explica como criar um instalador Windows para o Project Hyperion.

## Requisitos

- `cmake` instalado e disponível no PATH
- `Qt6` com WebEngine e WebChannel
- `makensis` instalado (NSIS)
- `ninja` ou outro gerador CMake

## Passos

1. Configure o build:
   ```powershell
   cmake --preset debug
   ```
2. Compile:
   ```powershell
   cmake --build --preset debug
   ```
3. Gere o instalador:
   ```powershell
   .\packaging\windows\build_installer.ps1
   ```

## Resultado

- `packaging/windows/HyperionInstaller.exe`
- `build/Debug/ProjectHyperion.exe`

## Observações

- O instalador NSIS copia o exe e cria atalhos no Desktop e no menu Iniciar.
- Você pode adaptar o script NSIS para incluir `README.md`, licença e outros recursos.
