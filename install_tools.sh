#!/usr/bin/env bash
set -e

TOOLPATH="/opt/tools"

echo "====================================================="
echo "Project Hyperion Tool Installer"
echo "====================================================="

default_path="$TOOLPATH"

echo "1) Instalar em $default_path"
echo "2) Instalar em $HOME/tools"
echo "3) Escolher caminho customizado"
read -rp "Escolha a opcao desejada [1]: " option
option=${option:-1}

case "$option" in
  1)
    TOOLPATH="/opt/tools"
    ;;
  2)
    TOOLPATH="$HOME/tools"
    ;;
  3)
    read -rp "Digite o caminho completo para a pasta de ferramentas: " custom_path
    TOOLPATH="${custom_path:-/opt/tools}"
    ;;
  *)
    echo "Opcao invalida. Usando /opt/tools."
    TOOLPATH="/opt/tools"
    ;;
esac

if [ "$TOOLPATH" = "/opt/tools" ] && [ "$(id -u)" -ne 0 ]; then
  echo "Necessario privilegio de root para criar /opt/tools. Tentando sudo..."
  exec sudo bash "$0" "$@"
fi

mkdir -p "$TOOLPATH"
echo "Pasta de ferramentas criada/confirmada em: $TOOLPATH"

read -rp "Digite o caminho absoluto do ninja.exe para copiar (ou deixe vazio para pular): " ninja_input
if [ -n "$ninja_input" ]; then
  if [ -f "$ninja_input" ]; then
    cp "$ninja_input" "$TOOLPATH/ninja.exe"
    chmod +x "$TOOLPATH/ninja.exe"
    echo "ninja.exe copiado para $TOOLPATH/ninja.exe"
  else
    echo "Arquivo nao encontrado: $ninja_input"
  fi
else
  echo "Pulando copia do ninja.exe. Copie manualmente para $TOOLPATH/ninja.exe se desejar."
fi

echo ""
echo "Instalador finalizado."
echo "Adicione $TOOLPATH ao PATH se quiser usar ninja diretamente."
