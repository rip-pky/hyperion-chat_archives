# Versão Legacy Web em PHP

Esta pasta contém a versão em PHP projetada para navegadores antigos.

## Arquivos principais

- `legacy_web/index.php`: página principal legada com suporte a HTML 4.01 Transitional.
- `legacy_web/dev.php`: versão de desenvolvimento com painel de debug e limpeza de sessão.
- `legacy_web/download_css.php`: permite baixar o CSS como arquivo.
- `legacy_web/css/style.css`: estilo básico para navegadores antigos.
- `legacy_web/css/dev.css`: estilo de desenvolvimento.

## Como usar

1. Coloque a pasta `legacy_web/` em um servidor PHP.
2. Acesse `index.php` para a versão legacy.
3. Acesse `dev.php` para a versão de desenvolvimento.
4. Use `download_css.php` para baixar o arquivo CSS.

## Compatibilidade

- HTML 4.01 Transitional.
- CSS básico e sem recursos modernos como flexbox ou grid.
- Navegadores antigos devem exibir corretamente a página.
