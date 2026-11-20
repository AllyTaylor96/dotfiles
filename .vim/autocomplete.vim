""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:StartPythonCompletion() abort
    let b:pyac.completeopt = &l:completeopt
    let &l:completeopt = &completeopt
    setlocal completeopt-=longest
    setlocal completeopt+=menuone,noselect
endfunction

function! s:RestoreCompletionOptions() abort
    let &l:completeopt = remove(b:pyac, 'completeopt')
endfunction

function! s:TogglePythonAutocomplete() abort
    if exists('b:pyac')
        silent! iunmap <buffer> .
        if get(b:pyac.dotmap, 'buffer', 0)
            call mapset('i', 0, b:pyac.dotmap)
        endif
        let &l:omnifunc = b:pyac.omnifunc
        unlet b:pyac
        echomsg 'Python autocomplete disabled for this buffer'
        return
    endif

    if &l:filetype !=# 'python' || !has('python3')
        echoerr 'Pyac: requires a Python buffer and Vim with +python3'
        return
    endif

    let l:venv = python3complete#Venv()
    let b:pyac = {'omnifunc': &l:omnifunc, 'dotmap': maparg('.', 'i', 0, 1),
        \ 'venv_paths': l:venv.paths}
    setlocal omnifunc=python3complete#Complete
    inoremap <buffer> <expr> . &l:filetype ==# 'python'
        \ ? ".\<Cmd>call <SID>StartPythonCompletion()\<CR>\<C-x>\<C-o>\<Cmd>call <SID>RestoreCompletionOptions()\<CR>"
        \ : "."
    echomsg 'Python autocomplete enabled for this buffer (imports can execute code)'
    if has_key(l:venv, 'warning')
        echohl WarningMsg
        echomsg 'Pyac: ' . l:venv.warning
        echohl None
    endif
endfunction

command! Pyac call <SID>TogglePythonAutocomplete()
