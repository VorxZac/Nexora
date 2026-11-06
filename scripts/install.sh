#!/usr/bin/env bash
# Copy the repository configurations to the user's config directory.
# This script does not install packages or modify shell startup files.

set -euo pipefail

case "$(uname -s)" in
    Linux|Darwin)
        ;;
    *)
        printf 'Unsupported operating system. Use the manual instructions in README.md.\n' >&2
        exit 1
        ;;
esac

: "${HOME:?HOME must be set}"

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

copy_config() {
    local source="$1"
    local destination_dir="$2"

    mkdir -p "$destination_dir"
    cp "$source" "$destination_dir/"
}

copy_config "$REPO_DIR/oh-my-posh/config.json" "$CONFIG_HOME/oh-my-posh"
copy_config "$REPO_DIR/oh-my-posh/config.schema.json" "$CONFIG_HOME/oh-my-posh"
copy_config "$REPO_DIR/fastfetch/config.jsonc" "$CONFIG_HOME/fastfetch"
copy_config "$REPO_DIR/cava/config" "$CONFIG_HOME/cava"

if [ -f "$REPO_DIR/assets/L2.png" ]; then
    copy_config "$REPO_DIR/assets/L2.png" "$CONFIG_HOME/fastfetch"
fi

printf 'Configuration files copied to %s.\n' "$CONFIG_HOME"
printf 'Existing files with the same names were replaced.\n'
printf 'No packages were installed and no shell profile was changed.\n'
