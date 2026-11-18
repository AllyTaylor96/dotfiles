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
