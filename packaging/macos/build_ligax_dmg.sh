#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
OUTPUT_DIR="$PROJECT_ROOT/dist/macos"
APP_NAME="Hyperion"
DMG_NAME="Hyperion-mac.dmg"
PKG_NAME="Hyperion-mac.pkg"

mkdir -p "$OUTPUT_DIR"

echo "Buildando Project Hyperion para macOS..."
cmake --preset debug
cmake --build --preset debug

APP_DIR="$OUTPUT_DIR/$APP_NAME.app"
mkdir -p "$APP_DIR/Contents/MacOS"
cp "$BUILD_DIR/ProjectHyperion" "$APP_DIR/Contents/MacOS/$APP_NAME"

cat > "$APP_DIR/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleName</key>
    <string>$APP_NAME</string>
    <key>CFBundleExecutable</key>
    <string>$APP_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>com.hyperion.$APP_NAME</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
</dict>
</plist>
EOF

PKG_PATH="$OUTPUT_DIR/$PKG_NAME"
DMG_PATH="$OUTPUT_DIR/$DMG_NAME"

pkgbuild --root "$APP_DIR" --identifier "com.hyperion.$APP_NAME" --version "1.0" "$PKG_PATH"

echo "Criando DMG..."
hdiutil create -volname "$APP_NAME" -srcfolder "$APP_DIR" -ov -format UDZO "$DMG_PATH"

echo "Pacotes criados:"
echo "  $PKG_PATH"
echo "  $DMG_PATH"
