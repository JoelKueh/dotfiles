" Editing Configuration
setlocal colorcolumn=100
setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal textwidth=100
setlocal formatoptions+=t
setlocal showbreak="↪ "

" Compiler Setup
setlocal makeprg=typst\ compile\ %:S
setlocal errorformat=%Eerror:\ %m,%Wwarning:\ %m,%C\ %#┌─\ %f:%l:%c,%Z
nnoremap <buffer><silent> <leader>m :silent make! \| redraw! \| cwindow<CR>
