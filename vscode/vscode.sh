#!/bin/bash
# Install a lean VS Code extension set + Cursor Dark theme.
# Requires the `code` CLI on PATH (VS Code → Shell Command: Install 'code' command).

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_CODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"

# Prefer the app binary — shell aliases named `code` are not usable here.
if [[ -n "${CODE_BIN:-}" && -x "$CODE_BIN" ]]; then
  :
elif [[ -x "$APP_CODE" ]]; then
  CODE_BIN="$APP_CODE"
elif command -v code >/dev/null 2>&1 && [[ -x "$(command -v code)" ]]; then
  CODE_BIN="$(command -v code)"
else
  echo "VS Code CLI not found at $APP_CODE" >&2
  exit 1
fi

install() {
  "$CODE_BIN" --force --install-extension "$1" >/dev/null
  echo "  + $1"
}

echo "Installing Cursor Dark theme (local)…"
EXT_DIR="${VSCODE_EXTENSIONS_DIR:-$HOME/.vscode/extensions}/luke-h1.cursor-dark-1.0.0"
mkdir -p "$(dirname "$EXT_DIR")"
rm -rf "$EXT_DIR"
cp -R "$ROOT/extensions/cursor-dark" "$EXT_DIR"
echo "  + luke-h1.cursor-dark → $EXT_DIR"

echo "Installing lean extensions…"
# Core editing
install esbenp.prettier-vscode
install dbaeumer.vscode-eslint
install mikestead.dotenv
install eamodio.gitlens
install redhat.vscode-yaml

# Languages you actually use
install ms-python.python
install golang.go
install Prisma.prisma
install Vue.volar
install expo.vscode-expo-tools
install swiftlang.swift-vscode
install astro-build.astro-vscode
install Dart-Code.dart-code
install hashicorp.terraform
install blazejkustra.react-compiler-marker
install anthropic.claude-code

echo "Uninstalling bloat (ignore errors if missing)…"
bloat=(
  vscode-icons-team.vscode-icons
  wayou.vscode-todo-highlight
  Gruntfuggly.todo-tree
  kamikillerto.vscode-colorize
  ecmel.vscode-html-css
  zignd.html-css-class-completion
  pranaygp.vscode-css-peek
  formulahendry.auto-rename-tag
  knisterpeter.vscode-commitizen
  TomiTurtiainen.rf-intellisense
  simonsiefke.svg-preview
  christian-kohler.path-intellisense
  styled-components.vscode-styled-components
  antfu.slidev
  redhat.java
  sswg.swift-lang
)
for ext in "${bloat[@]}"; do
  "$CODE_BIN" --uninstall-extension "$ext" >/dev/null 2>&1 && echo "  - $ext" || true
done

echo "Done. Reload VS Code window to apply Cursor Dark."
