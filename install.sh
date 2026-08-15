#!/usr/bin/env bash
#
# Usage:
#   ./install.sh          copy the extension files (regular install)
#   ./install.sh --link   symlink this checkout instead (for development)

set -euo pipefail

readonly UUID="no-update-on-shutdown@pndhd1.github.io"
readonly SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TARGET="${XDG_DATA_HOME:-$HOME/.local/share}/gnome-shell/extensions/$UUID"

mkdir -p "$(dirname "$TARGET")"
rm -rf "$TARGET"

if [[ "${1:-}" == "--link" ]]; then
    ln -s "$SOURCE" "$TARGET"
else
    mkdir -p "$TARGET"
    cp "$SOURCE"/{metadata.json,extension.js} "$TARGET"
fi
echo "Installed $TARGET"

if ! gnome-extensions enable "$UUID" 2>/dev/null; then
    enabled="$(gsettings get org.gnome.shell enabled-extensions)"
    case "$enabled" in
        *"'$UUID'"*) ;;
        '@as []' | '[]') gsettings set org.gnome.shell enabled-extensions "['$UUID']" ;;
        *) gsettings set org.gnome.shell enabled-extensions "${enabled%]}, '$UUID']" ;;
    esac
fi
echo "Enabled $UUID — log out and back in to load it."
