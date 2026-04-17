# Pasta tools

Coloque o `ninja.exe` nesta pasta para que os scripts do projeto o encontrem facilmente.

## Uso

- Crie a pasta `tools` na raiz do projeto
- Copie `ninja.exe` para `tools\ninja.exe`
- Ou execute `wizard_install.bat` ou `wizard_install.ps1` para instalar Ninja automaticamente sem solicitar elevação de administrador sempre que possível
- Depois rode `build_and_run.bat` ou `build_and_run.ps1`

## Comportamento

Os scripts tentam usar primeiro `tools\ninja.exe` no projeto.
Se não encontrarem, tentam usar `C:\tools\ninja.exe` como fallback.
