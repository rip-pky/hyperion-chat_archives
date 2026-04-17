# Packaging Linux

Este documento descreve como empacotar o Project Hyperion no Linux.

## Nome do pacote

A versão Linux é chamada `Ligax` para diferenciar do build Windows.

## Requisitos

- `cmake` instalado
- `Qt6` com WebEngine e WebChannel
- `tar`, `gzip`

## Passos

1. Configure o build:
   ```bash
   cmake --preset debug
   ```
2. Compile:
   ```bash
   cmake --build --preset debug
   ```
3. Gere o pacote:
   ```bash
   ./packaging/linux/build_ligax_package.sh
   ```

## Resultado

- `dist/linux/Ligax.tar.gz`

## Observações

- O script copia o binário `ligax`, a pasta `legacy_web/` e a documentação Markdown.
- Você pode estender o script para gerar um AppImage ou Snap.
