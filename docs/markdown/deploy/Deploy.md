# Guia de Deploy e Fork

Esta documentação explica como implantar o projeto e criar um fork ou mod.

## Deploy básico

1. Instale o servidor PHP ou use o `php -S localhost:8000`.
2. Aponte o servidor para a pasta `legacy_web/`.
3. Acesse `http://localhost:8000/index.php`.

## Criando um fork ou mod

- Copie o diretório `legacy_web/` para o seu fork.
- Edite `index.php`, `dev.php` e `css/style.css` para ajustar a interface e o comportamento.
- Adicione temas ou recursos extensíveis sem depender de JavaScript avançado.

## Deploy para produção

- Use um servidor web que suporte PHP 7.4+.
- Proteja o `legacy_web/` de acesso indesejado se for expor dados reais.
- Mantenha o CSS em um arquivo separado para download e modificação.

## Estrutura de mod

- `legacy_web/`: base do site.
- `legacy_web/css/`: temas e estilos.
- `legacy_web/dev.php`: ambiente de desenvolvimento.
- `docs/markdown/`: documentação para colaboradores.
