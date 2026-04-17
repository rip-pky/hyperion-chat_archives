# Project Hyperion

Projeto inicial para um chat gamer com privacidade extrema, moderação ativa e personalização avançada de perfil.

## Visão geral

Project Hyperion é um cliente de chat C++ com foco em:
- interface gamer Dark Gamer e leve
- UI inspirada em Discord com comunidades e canais
- perfil personalizável com nickname, status e temas
- buffer de mídia em RAM sem gravar no disco
- comunicação TCP/TLS criptografada
- watchdog Python com autenticação HWID e proteção de integridade

## Estrutura do projeto

- `src/`: frontend C++ Qt6 usando Qt WebEngine para interface HTML/CSS, lógica de perfil e rede
- `legacy_web/`: versão web legacy em PHP para navegadores antigos
- `backend/`: watchdog Python, HWID allowlist e blacklist de hashes
- `lua/`: port da interface e lógica de comunidade/canais para Lua
- `cmake/`: configuração e documentação de build CMake para facilitar open source
- `docs/html/`: documentação completa em HTML
- `docs/webclip/`: versão leve para previews e webclip
- `docs/markdown/`: documentação robusta em Markdown para desenvolvimento e deploy
- `deploy/`: scripts e instruções para empacotar o projeto e criar mods/forks
- `packaging/`: scripts e instaladores para Windows, Linux e macOS

## Packaging e versões multiplataforma

- `packaging/windows/`: gera instalador NSIS para Windows
- `packaging/linux/`: empacota a versão Linux `Ligax` como tarball ou AppImage futuro
- `packaging/macos/`: gera `.pkg` e `.dmg` para macOS
- `legacy_web/`: versão PHP legada para browsers antigos

## Recursos principais

### Interface e personalização
- painel de perfil com nickname, status e disponibilidade
- diálogo de perfil para editar nickname, status e tema
- temas disponíveis:
  - Dark Gamer
  - Material Design 3
  - Stealth Console

### Segurança de mídia
- `MediaBufferManager` carrega arquivos em RAM
- limpeza imediata do buffer com `memset`
- evita gravação de mídia sensível em SSD

### Rede e privacidade
- `SecureSocketClient` usa `QSslSocket`
- protocolo de mensagem com frame seguro
- handshake inicial com HWID no cliente

### Watchdog backend
- servidor TLS Python em `backend/watchdog.py`
- autenticação HWID contra `backend/hwid_allowlist.json`
- rate limiting anti-spam e brute force
- verificação de integridade de conteúdo proibido via `backend/blacklist_hashes.json`

## Como compilar

### Requisitos
- `CMake` instalado e disponível no PATH
- `ninja` instalado ou `tools\ninja.exe` presente no diretório do projeto (fallback `C:\tools\ninja.exe`)
- Qt6 instalado com componentes `Core`, `Gui`, `Widgets`, `Network`, `WebEngineWidgets` e `WebChannel`
- Compilador C++ compatível (MSVC ou MinGW)

### Passos
```powershell
cd C:\Users\PC\Desktop\project_hyperion
cmake --preset debug
cmake --build --preset debug
```

### Preparar ferramentas
- No Windows, execute `wizard_install.bat` para configurar `C:\tools` ou `tools\` local sem pedir elevação de administrador.
- No Windows, também é possível usar `install_tools.bat` se quiser copiar o ninja manualmente.
- No Linux, execute `./install_tools.sh` para configurar `/opt/tools` ou `~/tools`.

### Wizard de instalação
- `wizard_install.bat`: instala Ninja automaticamente no Windows sem solicitar permissão de administrador sempre que possível.
- `wizard_install.ps1`: faz o mesmo em PowerShell.

### Rodar o executável
```powershell
build\Debug\ProjectHyperion.exe
```

### Scripts automáticos
- PowerShell:
```powershell
cd C:\Users\PC\Desktop\project_hyperion
powershell -ExecutionPolicy Bypass -File build_and_run.ps1
```
- Batch:
```bat
cd C:\Users\PC\Desktop\project_hyperion
build_and_run.bat
```
- Executar binário compilado:
```bat
cd C:\Users\PC\Desktop\project_hyperion
run_project.bat
```

## Uso no VS Code

- `Run` > `Start Debugging` para `Debug ProjectHyperion`
- `Run Python Watchdog` para iniciar `backend/watchdog.py`
- `Terminal` > `Run Task...` para `CMake: Configure` e `CMake: Build`

## Configuração de segurança

- coloque `server.pem` e `server.key` em `backend/`
- atualize `backend/hwid_allowlist.json` com HWIDs autorizados
- atualize `backend/blacklist_hashes.json` com hashes proibidos

## Documentação

- `docs/html/index.html`: guia completo do projeto
- `docs/html/profile.html`: customização de perfil e temas
- `docs/markdown/`: documentação organizada por categorias
- `docs/templates/`: base de template HTML/CSS/JS/TS/PHP para hospedar sua comunidade
- `lua/`: port Lua do frontend e lógica de comunidades/canais
- `docs/webclip/index.html`: resumo rápido para preview

## Observações

- O projeto separa frontend e backend para ampliar segurança e testes
- A pasta `backend/` contém o watchdog Python separado do cliente C++
- O sistema foi pensado para uma pipeline de segurança ARM-friendly
