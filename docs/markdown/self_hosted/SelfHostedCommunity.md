# Self-Hosted Community Guide

O Project Hyperion é um protocolo de chat descentralizado. Esta página mostra como montar sua própria comunidade self-hosted com front-end, back-end C++ e segurança reforçada.

## 1. Template Base

O template é dividido em:
- `community_template.html` — cabeçalho, sidebar de canais, lista de membros e chat central.
- `community_template.css` — visual cyberpunk, contrastes fortes e layout responsivo.
- `community_template.js` — lógica básica de seleção de canal, envio de mensagem e atualização do chat.
- `community_template.ts` — versão tipada do mesmo comportamento para ambientes TypeScript.
- `community_template.php` — renderização PHP para quem precisa de um front-end legado ou de servidor.

### Estrutura de interface

- Header com nome da comunidade, banner, avatar e descrição.
- Sidebar de canais com estados ativos e botões de criação rápida.
- Área central de chat dinâmica com mensagens e input.
- Painel lateral de membros conectados.

## 2. Guia Step-by-Step de Hospedagem

1. Copie o template de `docs/templates/` para o seu projeto.
2. Abra `community_template.js` ou `community_template.ts` e ajuste o endereço IP do servidor real.
3. No C++ backend, garanta que o `QWebEngineView` carregue sua página customizada em vez do template padrão.
4. Compile o backend com `cmake --preset debug` e `cmake --build --preset debug`.
5. Inicie o backend e exponha o IP/porta usados pelo Hyperion.
6. No cliente, configure o endereço do servidor para `http://SEU_IP:PORTA` ou a URL local do arquivo.

### Exemplo de configuração de IP

No template JS/TS:

```js
const SERVER_ENDPOINT = 'http://192.168.0.42:8080';
```

No backend C++:

```cpp
socketClient->connectToServer("192.168.0.42", 4433);
```

Depois disso, suba o servidor e conecte o cliente.

## 3. IDE Integrada & Configuração

Imagine uma IDE simplificada rodando dentro do Hyperion:

- editor de HTML/CSS/JS embutido.
- live preview do template no painel central.
- salvamento local rápido e rede de deploy direto para a comunidade.
- painel de configuração para IP, porta, TLS, e rota do backend.

Essa IDE não precisa ser pesada. Ela deve ser:

- minimalista: painel de arquivos, editor e botão `Preview`.
- realtime: alterações aplicadas ao template imediatamente.
- segura: mantém o código local e apenas sincroniza com o seu servidor.

A ideia é que qualquer administrador de comunidade possa criar e alterar o front-end sem sair do Hyperion.

## 4. Segurança e Watch Dogs

No universo cyberpunk, a liberdade exige segurança.

### Por que isso importa

- comunidades self-hosted são alvos fáceis se rodarem sem proteção.
- o backend C++ e o watcher Python formam a camada de defesa inicial.
- o template HTML/JS é a superfície; o backend é o filtro.

### Configurando Watch Dogs

O sistema já vem pré-configurado para filtrar:
- ataques de injeção básicos
- mensagens com conteúdo impróprio
- conexões não autorizadas por HWID
- flood e brute force

Edite o arquivo de configuração para elevar a proteção:

- `backend/hwid_allowlist.json` para liberar dispositivos específicos.
- `backend/blacklist_hashes.json` para bloquear arquivos e payloads maliciosos.
- `backend/watchdog.py` para ajustar rate limiting e regras de bloqueio.

### Como subir o nível

1. Crie regras de palavra-chave e padrões regex no watcher.
2. Aplique verificações de payload antes de aceitar qualquer mensagem.
3. Reforce TLS e valide certificados no cliente e servidor.
4. Use logging estruturado para auditoria; detecte padrões de ataque.

### Recomendação técnica

- mantenha os endpoints do servidor restritos a IPs confiáveis.
- não exponha endpoints de gestão sem autenticação forte.
- habilite o modo `self-hosted`: cada comunidade controla seu próprio servidor.

## Resultado

Com este guia, o usuário tem:
- um template base pronto para customizar
- um caminho claro para configurar IP, compilar e subir o backend
- um conceito de IDE integrada no Hyperion
- uma visão de como usar o Watch Dog para manter a comunidade viva e segura

A liberdade vem com controle: use o protocolo descentralizado para criar sua própria comunidade e mantenha as chaves fora de mãos alheias.
