" Editing Configuration
setlocal colorcolumn=100
set expandtab
set tabstop=2
set shiftwidth=2
set textwidth=100
set formatoptions+=t
set showbreak="↪ "

" Compiler Setup
setlocal makeprg=typst\ compile\ %:S
setlocal errorformat=%Eerror:\ %m,%Wwarning:\ %m,%C\ %#┌─\ %f:%l:%c,%Z
nnoremap <buffer><silent> <leader>m :silent make! \| redraw! \| cwindow<CR>
