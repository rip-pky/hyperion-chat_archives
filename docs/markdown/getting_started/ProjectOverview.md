# Visão Geral do Project Hyperion

Project Hyperion é um projeto multi-plataforma com frontend Qt/C++ e uma versão web legacy em PHP para navegadores antigos.

## Estrutura do projeto

- `src/`: frontend principal em C++ com Qt6 e Qt WebEngine.
- `legacy_web/`: versão web em PHP legada para navegadores antigos.
- `backend/`: watchdog Python, HWID allowlist e blacklist de hash.
- `cmake/`: presets e documentação de build.
- `docs/html/`: documentação em HTML pronta para navegador.
- `docs/webclip/`: documentação leve para previews.
- `docs/markdown/`: documentação em Markdown para desenvolvedores e deploy.
