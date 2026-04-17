#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
OUTPUT_DIR="$PROJECT_ROOT/dist/linux"
PACKAGE_NAME="Ligax"

mkdir -p "$OUTPUT_DIR"

echo "Buildando Project Hyperion para Linux..."
cmake --preset debug
cmake --build --preset debug

BIN_PATH="$BUILD_DIR/ProjectHyperion"
if [[ ! -f "$BIN_PATH" ]]; then
  echo "Executável não encontrado em $BIN_PATH"
  exit 1
fi

PACKAGE_PATH="$OUTPUT_DIR/${PACKAGE_NAME}.tar.gz"
mkdir -p "$OUTPUT_DIR/$PACKAGE_NAME"
cp "$BIN_PATH" "$OUTPUT_DIR/$PACKAGE_NAME/ligax"
cp -r "$PROJECT_ROOT/legacy_web" "$OUTPUT_DIR/$PACKAGE_NAME/legacy_web"
cp -r "$PROJECT_ROOT/docs/markdown" "$OUTPUT_DIR/$PACKAGE_NAME/docs_markdown"

tar -czf "$PACKAGE_PATH" -C "$OUTPUT_DIR" "$PACKAGE_NAME"
rm -rf "$OUTPUT_DIR/$PACKAGE_NAME"

echo "Pacote Linux criado: $PACKAGE_PATH"
