# Packaging macOS

Este documento descreve como empacotar o Project Hyperion para macOS.

## Requisitos

- `cmake` e `ninja`
- `Qt6` com WebEngine e WebChannel
- `pkgbuild` e `hdiutil`

## Passos

1. Configure o build:
   ```bash
   cmake --preset debug
   ```
2. Compile:
   ```bash
   cmake --build --preset debug
   ```
3. Gere os pacotes:
   ```bash
   ./packaging/macos/build_ligax_dmg.sh
   ```

## Resultado

- `dist/macos/Hyperion-mac.pkg`
- `dist/macos/Hyperion-mac.dmg`

## Observações

- O script cria um `.app` básico com `Info.plist` e empacota em `.dmg`.
- Para produção, use `macdeployqt` para embutir dependências Qt no aplicativo.
