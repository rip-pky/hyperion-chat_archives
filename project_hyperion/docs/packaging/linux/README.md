# Packaging Linux

Este diretório descreve como criar pacotes Linux para o Project Hyperion, incluindo uma versão chamada `Ligax`.

## Requisitos

- `cmake` e `ninja` ou outro gerador instalado.
- Qt6 com WebEngine e WebChannel.
- `tar`, `gzip`.

## Uso

1. Compile o projeto:
   ```bash
   cmake --preset debug
   cmake --build --preset debug
   ```
2. Crie o pacote:
   ```bash
   ./packaging/linux/build_ligax_package.sh
   ```

## Produto final

- `Ligax.tar.gz` com o binário `ligax` e arquivos necessários.
- `Ligax.AppImage` (se você estender o script para criar AppImage).

## Observação

Para Linux, o app pode ser distribuído como binário estático ou tarball com dependências compartilhadas.
