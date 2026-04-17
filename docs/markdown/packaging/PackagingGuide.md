# Guia de Packaging Avançado

Este guia detalha como estruturar a build e o deploy do Project Hyperion para várias plataformas.

## Objetivo

- manter uma estrutura clara de `packaging/`
- separar builds por plataforma
- oferecer instaladores Windows e pacotes Linux/Mac
- suportar versões legacy e scripts de deploy

## Estrutura recomendada

- `packaging/windows/`
- `packaging/linux/`
- `packaging/macos/`
- `docs/markdown/`: documentação técnica para desenvolvedores

## Passos gerais

1. Configure `CMakePresets.json` para build multiplataforma.
2. Use `packaging/windows/build_installer.ps1` para criar o instalador Windows.
3. Use `packaging/linux/build_ligax_package.sh` para empacotar a versão Linux com nome `Ligax`.
4. Use `packaging/macos/build_ligax_dmg.sh` para gerar `.dmg` e `.pkg`.

## Notas

- O arquivo `legacy_web/` fornece uma versão PHP compatível com navegadores antigos.
- A documentação em Markdown é o ponto de referência para desenvolvedores e forks.
