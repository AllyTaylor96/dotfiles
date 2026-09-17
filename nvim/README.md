# How to work

Quickstart (Linux/macOS):

- `./bootstrap.sh`

Manual dependencies:

- `neovim` (0.10+), `git`, `ripgrep`, `make`, a C compiler (`gcc`/`clang`)
- `node`/`npm` - required by `mason.nvim` to install/manage the `pyright` language server
- `python3`/`pip` with `pylint` and `black` installed - used by `none-ls` for Python
  linting and formatting

```
pip3 install --user -U pylint black
```

On first launch, `lazy.nvim` installs all plugins and `mason.nvim` installs
`pyright` automatically - no manual language server setup required.

See [USER_GUIDE.md](./USER_GUIDE.md) for keybindings and feature details.
