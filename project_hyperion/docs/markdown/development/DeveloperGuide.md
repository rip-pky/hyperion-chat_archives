# Guia do Desenvolvedor

Use esta documentação para desenvolver, ajustar ou modificar o Project Hyperion.

## Visão geral do ambiente

- `src/`: código principal em C++ com Qt6 e Qt WebEngine.
- `legacy_web/`: versão PHP para navegador antigo.
- `backend/`: serviço watchdog Python.
- `docs/markdown/`: documentação orientada a desenvolvedores.

## Requisitos para desenvolvimento

- Qt6 com WebEngine e WebChannel.
- CMake 3.20+.
- PHP 7.x ou 8.x para `legacy_web/`.
- Um servidor web local como Apache ou PHP built-in.

## Desenvolvendo o frontend legacy

1. Abra `legacy_web/index.php`.
2. Modifique o HTML e o CSS em `legacy_web/css/style.css`.
3. Use `legacy_web/dev.php` para testar o modo de desenvolvimento.
4. Para baixar CSS, acesse `legacy_web/download_css.php`.

## Port Lua do frontend

- A pasta `lua/` contém um port da interface para Lua.
- `lua/ui.lua` modela comunidades, canais e mensagens em Lua.
- `lua/demo.lua` é um exemplo que demonstra como criar comunidades e enviar mensagens.
- Entre as próximas etapas estão integrar `lua/ui.lua` com um host de UI Lua ou renderizar a interface Lua para HTML.

## Comunidades self-hosted

- Cada usuário ou equipe deve hospedar sua própria instância do backend para criar a sua comunidade.
- A interface atual já suporta comunidades e canais locais com um esquema de UI inspirado em Discord.
- Consulte `docs/markdown/CommunityHosting.md` para instruções completas sobre deploy, servidor e canais.
