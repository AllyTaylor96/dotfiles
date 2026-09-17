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
  brew install neovim git ripgrep node python make gcc
elif [[ "$OS" == "Linux" ]] && have apt-get; then
  sudo apt-get update -y
  sudo apt-get install -y neovim git ripgrep nodejs npm python3 python3-pip make gcc
else
  echo "Unsupported OS/package-manager. Install manually: neovim, git, ripgrep, node/npm, python3/pip, make, a C compiler (gcc/clang)." >&2
  exit 1
fi

# Python tooling (used by none-ls for linting/formatting)
if have pip3; then
  pip3 install --user -U pylint black
elif have pip; then
  pip install --user -U pylint black
fi

# Note: the pyright LSP itself, along with any other language servers, is
# installed and managed automatically by mason.nvim on first launch - no
# manual step required beyond having node/npm available.

echo "Done. Launch nvim and let lazy.nvim/mason.nvim finish installing plugins and language servers."
