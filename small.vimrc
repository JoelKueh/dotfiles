let g:polyglot_disabled = ['markdown']

call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'menisadi/kanagawa.vim'
call plug#end()

set nocompatible
syntax on
filetype plugin indent on

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
if has('termguicolors')
  set termguicolors
endif

let g:airline_theme='minimalist'
let mapleader = "\<Space>"
colorscheme kanagawa

set hidden
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=longest:full,full
set timeout
set ttimeout
set timeoutlen=1000
set ttimeoutlen=10
set scrolloff=16

" Shift-delete fix for terminals that send this sequence.
inoremap <Esc>[3;2~ <BS>
cnoremap <Esc>[3;2~ <BS>

" Helix-like movement from the old vimrc.
nnoremap <silent> gl $
nnoremap <silent> gh 0
nnoremap <silent> ge G
vnoremap <silent> gl $
vnoremap <silent> gh 0
vnoremap <silent> ge G

" Tags and ripgrep.
set tags=./tags;,tags,./.tags;,.tags
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --glob\ !.git\ --glob\ !tags\ --glob\ !.tags
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -RIn\ --exclude-dir=.git\ --exclude=tags
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

function! s:ProjectRoot() abort
  let l:root = systemlist('git rev-parse --show-toplevel')
  if v:shell_error || empty(l:root)
    return getcwd()
  endif
  return l:root[0]
endfunction

function! s:ProjectFiles() abort
  let l:root = s:ProjectRoot()

  if executable('rg')
    let l:cmd = 'cd ' . shellescape(l:root) .
          \ ' && rg --files --hidden --follow --glob "!.git" --glob "!tags" --glob "!.tags"'
  elseif executable('fd')
    let l:cmd = 'cd ' . shellescape(l:root) .
          \ ' && fd --type f --hidden --follow --exclude .git --exclude tags --exclude .tags'
  else
    let l:cmd = 'cd ' . shellescape(l:root) .
          \ ' && find . -type f ! -path "./.git/*" ! -name tags ! -name .tags'
  endif

  let l:files = systemlist(l:cmd)
  if v:shell_error
    echohl ErrorMsg
    echom 'FindFiles failed: ' . l:cmd
    echohl None
    return []
  endif

  return map(l:files, 'fnamemodify(l:root . "/" . substitute(v:val, "^./", "", ""), ":p")')
endfunction

function! s:FindFiles(...) abort
  let l:query = a:0 ? a:1 : input('File: ')
  if empty(l:query)
    return
  endif

  let l:files = s:ProjectFiles()

  let l:pattern = escape(l:query, '\.^$~[]')
  call filter(l:files, 'fnamemodify(v:val, ":.") =~? l:pattern')

  let l:items = map(l:files, '{"filename": v:val, "lnum": 1, "col": 1, "text": fnamemodify(v:val, ":.")}')
  call setqflist([], 'r', {'title': 'FindFiles: ' . l:query, 'items': l:items})
  call s:QfOpenPicker()
endfunction

function! s:Rg(pattern, word) abort
  let l:pattern = empty(a:pattern) ? input('Rg: ') : a:pattern
  if empty(l:pattern)
    return
  endif

  if executable('rg')
    let l:flags = a:word ? ' --word-regexp' : ''
    let l:cmd = 'rg --vimgrep --smart-case --hidden --glob "!.git" --glob "!tags" --glob "!.tags"' .
          \ l:flags . ' -- ' . shellescape(l:pattern)
  else
    let l:cmd = 'grep -RIn --exclude-dir=.git --exclude=tags -- ' . shellescape(l:pattern) . ' .'
  endif

  execute 'cexpr system(' . string(l:cmd) . ')'
  call s:QfOpenPicker()
endfunction

function! s:RgWord() abort
  call s:Rg(s:Symbol(), 1)
endfunction

function! s:Symbol() abort
  return expand('<cword>')
endfunction

function! s:TagSelect(...) abort
  let l:name = a:0 ? a:1 : s:Symbol()
  if empty(l:name)
    let l:name = input('Tag: ')
  endif
  if !empty(l:name)
    execute 'tselect ' . l:name
  endif
endfunction

function! s:CtagsFea() abort
  let l:root = s:ProjectRoot()
  let l:scan_dir = isdirectory(l:root . '/src') ? 'src' : '.'
  execute '!cd ' . shellescape(l:root) . ' && ' .
        \ 'ctags -R -f tags --languages=SystemVerilog,Verilog --extras=+q --fields=+iaS ' .
        \ shellescape(l:scan_dir)
endfunction

function! s:QfOpenPicker() abort
  if &buftype !=# 'quickfix'
    let g:qf_picker_winid = win_getid()
  endif
  botright 12copen
endfunction

function! s:QfOpen(keep_focus) abort
  if &buftype !=# 'quickfix'
    return
  endif

  let l:qf_winid = win_getid()
  let l:qf_line = line('.')
  if l:qf_line < 1 || l:qf_line > len(getqflist())
    return
  endif

  let l:target_winid = get(g:, 'qf_picker_winid', 0)
  if win_id2win(l:target_winid)
    call win_gotoid(l:target_winid)
  endif
  execute 'cc ' . l:qf_line

  if a:keep_focus && win_id2win(l:qf_winid)
    call win_gotoid(l:qf_winid)
  elseif !a:keep_focus
    cclose
  endif
endfunction

command! -nargs=? FindFiles call <SID>FindFiles(<f-args>)
command! -nargs=? Rg call <SID>Rg(<q-args>, 0)
command! -nargs=? RgRefs call <SID>Rg(<q-args>, 1)
command! -nargs=? Tags call <SID>TagSelect(<q-args>)
command! CtagsFea call <SID>CtagsFea()

" Picker/search replacements.
nnoremap <silent> <leader>f :FindFiles<CR>
nnoremap <silent> <leader>e :Explore<CR>
nnoremap <silent> <leader>b :buffers<CR>:buffer<Space>
nnoremap <silent> <leader>j :jumps<CR>
nnoremap <leader>/ :Rg<Space>
nnoremap <leader> <leader>d :LspDocumentDiagnostics<CR>

" Quickfix navigation.
nnoremap <leader>qo :call <SID>QfOpenPicker()<CR>
nnoremap <leader>qc :cclose<CR>
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

" ctags-first definition/navigation.
nnoremap gd :execute 'tjump ' . <SID>Symbol()<CR>
nnoremap gD :execute 'tselect ' . <SID>Symbol()<CR>
nnoremap gvv :execute 'vertical stag ' . <SID>Symbol()<CR>
nnoremap gvs :execute 'stag ' . <SID>Symbol()<CR>
nnoremap gr :call <SID>RgWord()<CR>
nnoremap <leader>tt :Tags <C-r><C-w><CR>
nnoremap <leader>tn :execute 'tselect ' . <SID>Symbol()<CR>
nnoremap <leader>tp :tprevious<CR>
nnoremap <leader>tf :tfirst<CR>
nnoremap <leader>tl :tlast<CR>
nnoremap <leader>tpv :execute 'ptag ' . <SID>Symbol()<CR>
nnoremap <leader>tpc :pclose<CR>

augroup quickfix_picker
  autocmd!
  autocmd FileType qf nnoremap <buffer><silent> q :cclose<CR>
  autocmd FileType qf nnoremap <buffer><silent> o :call <SID>QfOpen(0)<CR>
  autocmd FileType qf nnoremap <buffer><silent> p :call <SID>QfOpen(1)<CR>
  autocmd FileType qf nnoremap <buffer> t <C-W><CR><C-W>T
  autocmd FileType qf nnoremap <buffer> v <C-W><CR><C-W>L
  autocmd FileType qf nnoremap <buffer> s <C-W><CR><C-W>K
augroup END

" Completion Setup

" Completion popup behavior
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Lsp Setup
set signcolumn=yes
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

" Try this if your Vim/plugin version supports diagnostic popups
let g:lsp_diagnostics_float_cursor = 1

if executable('pylsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['c', 'cc', 'cpp', 'h', 'hpp'],
        \ })
endif

" if executable('svlangserver')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'svlangserver',
"         \ 'cmd': {server_info->['svlangserver']},
"         \ 'allowlist': ['verilog', 'systemverilog'],
"         \ 'root_uri': {server_info -> s:ProjectRoot()},
"         \ 'workspace_config': {
"         \   'systemverilog': {
"         \     'includeIndexing': ['src/**/*.sv', 'src/**/*.v', 'src/**/*.svh']
"         \   }
"         \ }
"         \ })
" endif

if executable('verible-verilog-ls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'verible-verilog-ls',
        \ 'cmd': {server_info -> [
        \   'verible-verilog-ls',
        \   '--rules_config_search'
        \ ]},
        \ 'allowlist': ['verilog', 'systemverilog'],
        \ 'root_uri': {server_info -> s:ProjectRoot()}
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>r <plug>(lsp-rename)
    nmap <buffer> [r <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]r <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
