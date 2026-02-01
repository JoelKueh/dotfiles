
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'yegappan/lsp'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rose-pine/vim'
Plug 'catppuccin/nvim'
Plug 'edeneast/nightfox.nvim'
call plug#end()

" Specify this variable to enable the plugin feature.
let g:clap_plugin_experimental = v:true

" Global configs.
colorscheme rosepine
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

" Lsp command setup
nnoremap <silent> gd :LspGotoDefinition<CR>
nnoremap <silent> gi :LspGotoImpl<CR>
nnoremap <silent> K :LspHover<CR>
nnoremap <silent> <leader>ar :LspRename<CR>
nnoremap <silent> <leader>aa :LspCodeAction<CR>
nnoremap <silent> <leader>k :LspDiag current<CR>
nnoremap <silent> <leader>ln :LspDiag nextWrap<CR>
nnoremap <silent> <leader>ls :LspDiag show<CR>

" Language server setup
set shortmess+=cat
let lspOpts = #{
	\	autoHighlightDiags: v:true,
	\   semanticHighlight: v:true,
	\ }
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [#{
	\	  name: 'clangd',
	\	  filetype: ['c', 'cpp'],
	\	  path: '/usr/bin/clangd',
	\	  args: ['--background-index']
	\ }]
autocmd User LspSetup call LspAddServer(lspServers)
