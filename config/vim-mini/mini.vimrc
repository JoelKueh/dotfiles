" =============================================================================
" General VIM Settings
" =============================================================================

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

colo kanagawa
let mapleader = " "
set path+=**
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
set scrolloff=10

" Shift-delete fix for terminals that send this sequence.
inoremap <Esc>[3;2~ <BS>
cnoremap <Esc>[3;2~ <BS>

" Helix-like movement.
nnoremap <silent> gl $
nnoremap <silent> gh 0
nnoremap <silent> ge G
vnoremap <silent> gl $
vnoremap <silent> gh 0
vnoremap <silent> ge G

" =============================================================================
" Project Level Utilities
" =============================================================================

" Uses git rev-parse to find if we are in a git repo.
function! s:InGitRepo() abort
    return system('git rev-parse --is-inside-work-tree') =~ '^true'
endfunction

" Finds the project root if we are in a git repo, otherwise returns cwd.
function! s:ProjectRoot() abort
    let l:root = systemlist('git rev-parse --show-toplevel')
    if v:shell_error || empty(l:root)
        return getcwd()
    endif
    return l:root[0]
endfunction

" Generates ctags at ProjectRoot. Includes ./* and ./{src,inc,source,include}/**/*
function! s:CtagsGen() abort
    silent execute '!cd ' . shellescape(s:ProjectRoot()) . ' && ctags'
        \ . ' $(find . -maxdepth 1 -type f)'
        \ . ' $(find inc include src source -type f 2>/dev/null)'
    redraw!
endfunction

" =============================================================================
" Quickfix List Utilities
" =============================================================================

" Saves the current window to g:qf_picker_winid and open the quickfix window.
function! s:QfOpenPicker() abort
    if &buftype !=# 'quickfix'
        let g:qf_picker_winid = win_getid()
    endif
    botright 12copen
endfunction

" Selects an item in the quickfix, optionally returns focus to or closes qf.
function! s:QfSelect(preview, exit) abort
    if &buftype !=# 'quickfix'
        return
    endif

    let l:qf_winid = win_getid()
    let l:qf_line = line('.')
    let l:target_winid = get(g:, 'qf_picker_winid', 0)
    if win_id2win(l:target_winid)
        call win_gotoid(l:target_winid)
    endif
    execute 'cc ' . l:qf_line

    if a:preview && win_id2win(l:qf_winid)
        call win_gotoid(l:qf_winid)
    elseif a:exit
        cclose
    endif
endfunction

" =============================================================================
" Quickfix Pickers
" =============================================================================

" Searches for a file using git files
function! s:FindFile(pattern) abort
    let l:pattern = empty(a:pattern) ? input('FindFile: ') : a:pattern
    if empty(l:pattern)
        return
    endif

    let l:cmd = 'rg --files --hidden --glob "!.git"'
        \ . ' | rg -i -- ' . shellescape(l:pattern)
    call setqflist(map(systemlist(l:cmd), {_, f -> {'filename': f}}), 'r')
    call s:QfOpenPicker()
endfunction

" Searches for a word using ripgrep.
function! s:Rg(pattern, word) abort
    let l:pattern = empty(a:pattern) ? input('Rg: ') : a:pattern
    if empty(l:pattern)
        return
    endif

    let l:cmd = '!cd ' . shellescape(s:ProjectRoot()) . ' rg --vimgrep --smart-case --hidden '
        \ . ' --glob "!.git" --glob "!tags" --glob "!.tags"'
        \ . (a:word ? ' --word-regexp' : '') . ' -- ' . shellescape(l:pattern)
    execute 'cexpr system(' . string(l:cmd). ')'
    call s:QfOpenPicker()
endfunction

" =============================================================================
" Default Bindings
" =============================================================================

" Picker Commands
command! -nargs=1 FindFile call <SID>FindFile(<q-args>)
command! -nargs=1 Rg call <SID>Rg(<q-args>, 0)
command! -nargs=1 RgRefs call <SID>Rg(expand("<cword>"), 1)

" Picker Keybinds
nnoremap <leader>f :FindFile<Space>
nnoremap <silent> <leader>e :Explore<CR>
nnoremap <silent> <leader>b :buffers<CR>:buffer<Space>
nnoremap <silent> <leader>j :jumps<CR>
nnoremap <leader>/ :Rg<Space>
nnoremap <leader> <leader>d :LspDocumentDiagnostics<CR>

" CTags Navigation
nnoremap gd :execute 'tjump ' . <SID>Symbol()<CR>
nnoremap gD :execute 'tselect ' . <SID>Symbol()<CR>
nnoremap gvv :execute 'vertical stag ' . <SID>Symbol()<CR>
nnoremap gvs :execute 'stag ' . <SID>Symbol()<CR>
nnoremap <silent>gr :RgRefs<CR>
nnoremap <leader>tt :Tags <C-r><C-w><CR>
nnoremap <leader>tn :execute 'tselect ' . <SID>Symbol()<CR>
nnoremap <leader>tp :tprevious<CR>
nnoremap <leader>tf :tfirst<CR>
nnoremap <leader>tl :tlast<CR>
nnoremap <leader>tpv :execute 'ptag ' . <SID>Symbol()<CR>
nnoremap <leader>tpc :pclose<CR>

" Quickfix Navigation
nnoremap <leader>qo :call <SID>QfOpenPicker()<CR>
nnoremap <leader>qc :cclose<CR>
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

" Quickfix Window Keybinds
augroup quickfix_picker
  autocmd!
  autocmd FileType qf nnoremap <buffer><silent> q :cclose<CR>
  autocmd FileType qf nnoremap <buffer><silent> o :call <SID>QfSelect(0, 1)<CR>
  autocmd FileType qf nnoremap <buffer><silent> p :call <SID>QfSelect(1, 0)<CR>
  autocmd FileType qf nnoremap <buffer> t <C-W><CR><C-W>T
  autocmd FileType qf nnoremap <buffer> v <C-W><CR><C-W>L
  autocmd FileType qf nnoremap <buffer> s <C-W><CR><C-W>K
augroup END

