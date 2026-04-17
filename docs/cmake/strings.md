# Documentação de Strings do CMake

Este arquivo explica o significado das principais strings e variáveis usadas no `CMakeLists.txt` do projeto.

## `cmake_minimum_required(VERSION 3.20)`
Define a versão mínima do CMake necessária para processar o projeto.

## `project(ProjectHyperion LANGUAGES CXX)`
Registra o nome do projeto como `ProjectHyperion` e informa que ele usa a linguagem C++.

## `set(CMAKE_CXX_STANDARD 20)`
Define o padrão C++ como C++20.

## `set(CMAKE_CXX_STANDARD_REQUIRED ON)`
Faz com que a opção de padrão C++ seja obrigatória: se não houver suporte, o build falha.

## `set(CMAKE_POSITION_INDEPENDENT_CODE ON)`
Habilita `-fPIC` em plataformas que requerem código independente de posição (útil para bibliotecas).

## `find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets Network)`
Busca o Qt6 instalado e exige os componentes necessários ao projeto: `Core`, `Gui`, `Widgets` e `Network`.

## `set(CMAKE_AUTOMOC ON)`
Ativa geração automática de arquivos moc para classes Qt que usam `Q_OBJECT`.

## `set(CMAKE_AUTORCC ON)`
Ativa a geração automática de recursos Qt caso haja arquivos `.qrc`.

## `add_executable(ProjectHyperion ... )`
Define o executável principal do projeto e lista os arquivos-fonte usados na compilação.

## `target_include_directories(ProjectHyperion PRIVATE src)`
Adiciona o diretório `src/` como caminho de include privado para o target `ProjectHyperion`.

## `target_link_libraries(ProjectHyperion PRIVATE Qt6::Core Qt6::Gui Qt6::Widgets Qt6::Network)`
Faz o link do executável com as bibliotecas Qt necessárias.

## `install(TARGETS ProjectHyperion RUNTIME DESTINATION bin)`
Define a instalação do executável no diretório `bin` quando usar `cmake --install`.

---

# `CMakePresets.json`

## `version`
Define a versão do formato de presets do CMake.

## `cmakeMinimumRequired`
Indica a versão mínima do CMake que suporta esse arquivo de presets.

## `configurePresets`
Define diferentes perfis de configuração do CMake:
- `debug`: configura o projeto para build de debug.

### `name`
Identificador do preset.

### `generator`
Seleciona o gerador do CMake, por exemplo `Ninja` ou `Visual Studio`.

### `binaryDir`
Diretório onde o CMake colocará arquivos de build.

### `cacheVariables`
Variáveis de cache do CMake para definir opções de configuração automaticamente.

## `buildPresets`
Define como construir o projeto:
- `configurePreset`: usa o preset de configuração previamente definido.
- `configuration`: define a configuração de build como `Debug`.
