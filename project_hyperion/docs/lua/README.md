# Port Lua do UI do Project Hyperion

Este diretório contém uma versão port da interface de comunidades e canais para Lua.

## Objetivo

- portar a lógica de UI de JavaScript para Lua
- manter o esquema de comunidades/canais
- permitir prototipar comportamento em Lua antes de integrar a interface principal

## Arquivos

- `ui.lua`: módulo Lua que mantém o estado de comunidades, canais e mensagens
- `demo.lua`: exemplo de execução que demonstra a lógica de criação de comunidade, canal e envio de mensagem

## Uso

Execute com um interpretador Lua compatível:

```powershell
cd C:\Users\PC\Desktop\project_hyperion\lua
lua demo.lua
```

## Próximos passos

- integrar este módulo em um host Lua dentro do aplicativo principal
- adicionar suporte a renderização Lua->HTML ou Lua->Qt
- usar `ui.lua` como base para um frontend alternativo em Love2D, Nginx+Lua ou outra engine Lua
