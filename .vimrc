
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'menisadi/kanagawa.vim'
call plug#end()

" Global configs.
colorscheme kanagawa
let g:airline_theme='minimalist'
set tabstop=4
set relativenumber
let mapleader="\<Space>"

" A couple helix-like features.
nnoremap <silent> gl $
nnoremap <silent> gh 0
nnoremap <silent> ge G
vnoremap <silent> gl $
vnoremap <silent> gh 0
vnoremap <silent> ge G

" Picker setup.
cnoreabbrev theme Color
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>e :Explore<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>j :Jumps<CR>
nnoremap <silent> <leader>/ :Rg<CR>

" fzf Escaping Fix
set timeout
set ttimeout
set timeoutlen=1000
set ttimeoutlen=10
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
elseif executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
endif

" Language server setup
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

function! s:on_lsp_buffer_enabled() abort
    " Enable semantic highlights if the server supports it
    let g:lsp_semantic_text_tokens_enabled = 1

    " Map standard semantic categories to basic Vim syntax colors
    highlight link LspType                  Type
    highlight link LspClass                 StorageClass
    highlight link LspStruct                Structure
    highlight link LspParameter             Identifier
    highlight link LspVariable              Identifier
    highlight link LspProperty              Identifier
    highlight link LspEnumMember            Constant
    highlight link LspFunction              Function
    highlight link LspMethod                Function
    highlight link LspMacro                 Macro
    highlight link LspKeyword               Keyword
    highlight link LspComment               Comment
    highlight link LspString                String
    highlight link LspNumber                Number
    highlight link LspRegexp                String
    highlight link LspOperator              Operator
endfunction

augroup lsp_colors
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

