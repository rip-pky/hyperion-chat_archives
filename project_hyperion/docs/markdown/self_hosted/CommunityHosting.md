# Guia de Comunidades Self-Hosted

Este documento descreve como usar o Project Hyperion em um modelo de comunidade self-hosted, onde cada pessoa ou equipe roda sua própria instância e mantém seus próprios canais.

## Visão geral

O Project Hyperion já possui um layout de UI inspirado em Discord:
- lista de comunidades/servidores
- lista de canais por comunidade
- chat principal
- painel de membros

A ideia é que não exista um servidor central único. Cada comunidade deve hospedar seu próprio backend e disponibilizar a sua instância do Hyperion.

## Como funciona

1. Você cria uma comunidade no cliente.
2. Você hospeda o backend na sua máquina ou em um servidor de sua preferência.
3. Outros participantes se conectam à sua instância para entrar na comunidade.
4. Cada comunidade administra seus próprios canais, permissões e regras.

## Requisitos de hospedagem

- Python 3.10+ instalado
- OpenSSL configurado para gerar certificados TLS
- Qt6 WebEngine se for compilá-lo localmente
- Rede configurada para acesso entre cliente e servidor, se estiver em LAN ou internet

## Rodando o backend

O backend principal está em `backend/watchdog.py`.

1. Gere ou copie `server.pem` e `server.key` dentro de `backend/`.
2. Ajuste `backend/watchdog.py` para usar o `host` e a `port` desejados.
3. Execute:

```powershell
cd C:\Users\PC\Desktop\project_hyperion\backend
python watchdog.py
```

4. Abra o cliente Hyperion e conecte-se ao host/porta do backend.

## Criando sua comunidade

- No cliente, use o botão `Nova` na barra de comunidades.
- Defina o nome da comunidade e comece com o canal `# geral`.
- Use `Canal` na lista de canais para criar novos tópicos.

## Hospedando seu próprio servidor

Você pode hospedar sua comunidade de várias formas:

- Localmente no seu PC para uma comunidade privada.
- Em uma VPS ou servidor cloud para uma comunidade pública restrita.
- Em um container Docker, se desejar isolar o backend e controlar o ambiente.

### Exemplo de deploy básico

1. Coloque `backend/watchdog.py` no servidor.
2. Gere chaves TLS válidas.
3. Abra a porta configurada (padrão `4433`).
4. Configure o cliente para se conectar ao IP ou DNS do seu servidor.

## Canais e regras

- Cada comunidade pode criar canais independentes.
- Utilize `# geral` para conversas gerais.
- Utilize `# anúncios` para mensagens importantes.
- Utilize `# ajuda` para suporte e dúvidas.

## Segurança e privacidade

- Cada comunidade só deve aceitar membros que você autorizar.
- Mantenha as chaves TLS protegidas e atualize a lista de HWIDs se houver controle de acesso.
- Como a comunidade é self-hosted, você é responsável por backups e disponibilidade.

## Personalização de UI

O cliente já exibe um esquema de UI semelhante ao Discord. Para personalizar ainda mais:

- Modifique `ui/styles.css` para ajustar cores, bordas e layout.
- Modifique `ui/index.html` para adaptar a navegação de servidores e canais.
- Modifique `ui/app.js` para alterar o comportamento das comunidades e mensagens.

## Próximos passos

- Configure `backend/hwid_allowlist.json` para permitir conexões apenas de dispositivos específicos.
- Crie plugins ou scripts extras que sincronizem canais entre múltiplas instâncias, se necessário.
- Adapte o projeto para rodar como serviço no Windows ou Linux para manter a comunidade sempre online.
