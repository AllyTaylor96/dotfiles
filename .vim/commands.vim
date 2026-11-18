function! s:MakeTags() abort
    if !executable('ctags')
        echoerr 'MakeTags: ctags is not installed or not on PATH'
        return
    endif

    execute '!ctags -R -f .tags .'
    if v:shell_error
        echoerr 'MakeTags: ctags failed with exit status ' . v:shell_error
    endif
endfunction

command! MakeTags call <SID>MakeTags()
