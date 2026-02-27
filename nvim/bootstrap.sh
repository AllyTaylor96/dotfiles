#!/usr/bin/env bash
# This script bootstraps the dependencies for my Neovim config. It should be environment-agnostic (besides Windows)
# and can be re-run if you add new dependencies to the config.
set -euo pipefail

# Define function to check if a command exists
have() { command -v "$1" >/dev/null 2>&1; }

# Store OS type
OS="$(uname -s)"

if have brew; then
  brew update
  brew install neovim python node ripgrep pipx
elif [[ "$OS" == "Linux" ]] && have apt-get; then
  sudo apt-get update -y
  sudo apt-get install -y neovim python3 python3-pip pipx nodejs npm ripgrep
else
  echo "Unsupported OS/package-manager. Install manually: neovim, python3/pip, ruff, jedi-language-server, node/npm, bash-language-server." >&2
  exit 1
fi

# Python tooling (for F3 format + F4 ruff check, and python LSP)
if have pipx; then
  pipx ensurepath >/dev/null 2>&1 || true
  pipx install ruff >/dev/null 2>&1 || pipx upgrade ruff
  pipx install jedi-language-server >/dev/null 2>&1 || pipx upgrade jedi-language-server
  # Optional (only used if ruff is unavailable for formatting)
  pipx install black >/dev/null 2>&1 || pipx upgrade black
else
  python3 -m pip install --user -U ruff jedi-language-server black
fi

# Bash LSP (your config enables bashls)
if have npm; then
  npm install -g bash-language-server
fi

echo "Done. If commands aren't found, ensure ~/.local/bin is on PATH (pipx/pip --user)." 
