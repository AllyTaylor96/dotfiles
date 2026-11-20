### What is this?

This is a place where I can keep config files for various stuff - terminal settings, vim preferences, whatever comes to mind!

### Python completion in Vim

In classic Vim with `+python3`, run `:Pyac` in a trusted Python buffer to
enable member completion when typing `.`. Run `:Pyac` again to turn it off.
The opt-in applies only to that buffer and starts off in other buffers.
Only enable it for trusted code: completion can execute Python imports.

If you activate a venv before starting Vim, `:Pyac` also searches its
`site-packages`. The venv and Vim's embedded Python must use the same major
and minor version. To switch venvs, start a new Vim process from the shell.

### Optional Vim plugins

The Vim configuration works without plugins. To enable the plugins listed in
`.vim/plugins.vim`, start Vim with this configuration and run:

```vim
:VundleSetup
:PluginInstall
```

Restart Vim afterward. `:VundleSetup` requires Git, downloads Vundle only when
it is absent, and loads the plugin configuration immediately. It will not
overwrite an existing destination that does not contain Vundle.

Alternatively, install Vundle manually:

```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Then start Vim, run `:PluginInstall`, and restart Vim.
Use `:PluginUpdate` to update installed plugins manually.

The configured plugins are `tpope/vim-sensible` (defaults),
`tpope/vim-commentary` (`gcc` to toggle a line comment), and
`tpope/vim-surround` (for example, `cs"'` to change surrounding double quotes
to single quotes). Our options and mappings load after sensible's defaults.

Downloads live in `~/.vim/bundle`, not in this repository. `install.sh` remains
unchanged: it links `.vimrc`, which finds the modular configuration itself.
Machines without Vundle quietly skip the plugin setup; startup never downloads
or updates plugins.
