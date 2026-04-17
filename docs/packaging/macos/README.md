# Packaging macOS

Este diretório contém instruções para criar uma versão macOS do Project Hyperion.

## Requisitos

- Xcode Command Line Tools ou equivalente.
- `cmake` e `ninja` instalados.
- Qt6 com WebEngine e WebChannel.
- `hdiutil` e `pkgbuild` para gerar `.dmg` e `.pkg`.

## Uso

1. Compile o projeto:
   ```bash
   cmake --preset debug
   cmake --build --preset debug
   ```
2. Gere o pacote:
   ```bash
   ./packaging/macos/build_ligax_dmg.sh
   ```

## Produto final

- `Hyperion-mac.dmg`
- `Hyperion-mac.pkg`
