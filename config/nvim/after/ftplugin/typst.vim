" Editing Configuration
setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal formatoptions+=t
setlocal showbreak="↪ "
setlocal colorcolumn=120
setlocal textwidth=120

" Compiler Setup
setlocal makeprg=typst\ compile\ %:S
setlocal errorformat=%Eerror:\ %m,%Wwarning:\ %m,%C\ %#┌─\ %f:%l:%c,%Z
nnoremap <buffer><silent> <leader>m :silent make! \| redraw! \| cwindow<CR>
