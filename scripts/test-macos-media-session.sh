#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

mode="${1:-dev}"

case "$mode" in
    dev | package)
        ;;
    *)
        echo "Usage: $0 [dev|package]"
        echo
        echo "  dev      install deps, typecheck, then run the Electron dev app"
        echo "  package  install deps, typecheck, then build the macOS app package"
        exit 2
        ;;
esac

echo "==> Installing dependencies"
pnpm install

echo "==> Running typecheck"
pnpm run typecheck

if [[ "$mode" == "package" ]]; then
    echo "==> Building macOS package"
    pnpm run package:mac
else
    echo "==> Starting Electron dev app"
    echo "After Feishin opens, enable Settings -> Hotkeys -> Media Session, then restart the app."
    pnpm run dev
fi
