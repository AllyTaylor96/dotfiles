let s:plugins_file = expand('<sfile>:p:h') . '/plugins.vim'

function! s:MakeTags() abort
    if !executable('ctags')
        echoerr 'MakeTags: ctags is not installed or not on PATH'
        return
    endif

    execute '!ctags -R --exclude=.env --exclude=env -f .tags .'
    if v:shell_error
        echoerr 'MakeTags: ctags failed with exit status ' . v:shell_error
    endif
endfunction

command! MakeTags call <SID>MakeTags()

function! s:Lint() abort
    let l:filetype = &filetype
    if l:filetype ==# 'python'
        let l:compiler = 'pylint'
    elseif index(['sh', 'bash'], l:filetype) >= 0
        let l:compiler = 'shellcheck'
    else
        echoerr 'Lint: no linter configured for filetype "' . l:filetype . '"'
        return
    endif

    if empty(expand('%:p'))
        echoerr 'Lint: save the buffer to a file before linting'
        return
    endif
    if &modified
        echoerr 'Lint: save the file before linting so the linter checks current contents'
        return
    endif
    if !executable(l:compiler)
        echoerr 'Lint: ' . l:compiler . ' is not installed or not on PATH'
        return
    endif
    if empty(globpath(&runtimepath, 'compiler/' . l:compiler . '.vim'))
        echoerr 'Lint: Vim has no compiler configuration for ' . l:compiler
        return
    endif

    execute 'compiler ' . l:compiler
    silent make %
    cwindow
    silent redraw!
endfunction

command! Lint call <SID>Lint()

function! s:VundleSetup() abort
    let l:vundle_dir = expand('~/.vim/bundle/Vundle.vim')
    if !filereadable(l:vundle_dir . '/autoload/vundle.vim')
        if !empty(getftype(l:vundle_dir))
            echoerr 'VundleSetup: destination already exists but does not contain Vundle: ' . l:vundle_dir
            return
        endif
        if !executable('git')
            echoerr 'VundleSetup: git is not installed or not on PATH'
            return
        endif

        try
            call mkdir(fnamemodify(l:vundle_dir, ':h'), 'p')
        catch
            echoerr 'VundleSetup: could not create the bundle directory: ' . v:exception
            return
        endtry

        echomsg 'VundleSetup: downloading Vundle...'
        let l:output = system('git clone -- https://github.com/VundleVim/Vundle.vim.git ' . shellescape(l:vundle_dir))
        if v:shell_error
            echoerr 'VundleSetup: git clone failed: ' . trim(l:output)
            return
        endif
    endif

    execute 'source' fnameescape(s:plugins_file)
    echomsg 'Vundle is ready. Run :PluginInstall, then restart Vim.'
endfunction

command! VundleSetup call <SID>VundleSetup()
