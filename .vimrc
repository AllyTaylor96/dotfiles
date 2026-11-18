" Load the modular configuration relative to this file, including when symlinked.
let s:vim_config_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/.vim'
execute 'set runtimepath^=' . fnameescape(s:vim_config_dir)

execute 'source' fnameescape(s:vim_config_dir . '/plugins.vim')
execute 'source' fnameescape(s:vim_config_dir . '/options.vim')
execute 'source' fnameescape(s:vim_config_dir . '/keymaps.vim')
execute 'source' fnameescape(s:vim_config_dir . '/commands.vim')
execute 'source' fnameescape(s:vim_config_dir . '/autocmds.vim')
