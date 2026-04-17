# CMake Folder

Esta pasta contém arquivos de configuração e documentação para facilitar o build do Project Hyperion.

## O que há aqui

- `CMakePresets.json`: presets para configurar e compilar o projeto com CMake.
- `strings.md`: explicação de cada string e variável usada no `CMakeLists.txt` e nos presets.

## Como usar

No terminal, execute:

```powershell
cd C:\Users\PC\Desktop\project_hyperion
cmake --preset debug
cmake --build --preset debug
```

Se preferir usar o script do Windows, rode:

```powershell
build_and_run.bat
```

## Observação

O arquivo principal de build continua sendo `CMakeLists.txt` na raiz do projeto. Este diretório é apenas para facilitar configuração e documentação de CMake.
