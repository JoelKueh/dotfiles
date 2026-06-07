
-- Plugin Installation
vim.pack.add({
  'https://github.com/rebelot/kanagawa.nvim',           -- Cool colorscheme
  'https://github.com/folke/flash.nvim',                -- Helix-style word jump motions
  'https://github.com/folke/which-key.nvim',            -- Key mapping reference tool
  'https://github.com/nvim-telescope/telescope.nvim',   -- File picker (maybe try folke/snacks)
  'https://github.com/lewis6991/gitsigns.nvim',         -- Nice git utilities
  'https://github.com/rhysd/git-messenger.vim',         -- More git utilities
  'https://github.com/nvim-lua/plenary.nvim',           -- Rendering utilities used by telescope
  'https://github.com/neovim/nvim-lspconfig',           -- Auto configuration for common lsps
  'https://github.com/dgagn/diagflow.nvim',             -- Helix-style diagnostics
})

local utils = require("utils")
local lsp = require("lsp")

-- Generic Configuration
vim.cmd[[colorscheme kanagawa]]
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

-- Vim Keybind Configuration
--- Keybinds for jumping around places
vim.keymap.set({'n', 'v'}, 'ge', 'G')
vim.keymap.set({'n', 'v'}, 'gl', '$')
vim.keymap.set({'n', 'v'}, 'gh', '0')
vim.keymap.set({'n', 'v'}, 'gs', '^')
--- Comment Keybinds
vim.keymap.set('n', '<leader>c', 'gcc', { remap = true, desc = 'Toggle comment' })
vim.keymap.set('v', '<leader>c', 'gc', { remap = true, desc = 'Toggle comment selection' })
--- Clipboard Keybinds
vim.keymap.set('v', '<leader>y', '"+y', { remap = true, desc = 'Yank selection to clipboard' })
vim.keymap.set({'n', 'v'}, '<leader>p', '"+y', { remap = true, desc = 'Paste clipboard after selection' })
vim.keymap.set({'n', 'v'}, '<leader>P', '"+y', { remap = true, desc = 'Paste clipboard before selection' })

-- These keybinds are nasty
vim.keymap.del('n', 'gO')
vim.keymap.del('n', 'gx')
vim.keymap.set('n', 'g%', '<Nop>')
vim.keymap.set('n', 'g;', '<Nop>')
vim.keymap.set('n', 'g,', '<Nop>')

-- Which Key Configuration
local whichkey = require("which-key")
local tsbuiltin = require("telescope.builtin")
whichkey.setup({preset="helix", icons={mappings=false}})
whichkey.add({
    {'<leader>', name = 'Space', group = 'Space'},
    {'<leader>f', tsbuiltin.find_files, desc = 'Open file picker at current working directory'},
    {'<leader>F', find_files_relative, desc = 'Open file picker at current buffer\'s directory'},
    {'<leader>e', '<CMD>Explore<CR>', desc = 'Explore'},
    {'<leader>b', tsbuiltin.buffers, desc = 'Open buffer picker'},
    {'<leader>g', tsbuiltin.git_file, desc = 'Pick git file'},
    {'<leader>j', tsbuiltin.jumplist, desc = 'Open jumplist picker'},
    {'<leader>s', tsbuiltin.lsp_document_symbols, desc = 'Open symbol picker'},
    {'<leader>S', tsbuiltin.lsp_workspace_symbols, desc = 'Open workspace symbol picker'},
    {'<leader>d', tsbuiltin.diagnostics, desc = 'Open diagnostic picker'},
    {'<leader>D', tsbuiltin.lsp_workspace_diagnostics, desc = 'Open workspace diagnostic picker'},
    {'<leader>/', tsbuiltin.live_grep, desc = 'Global search in workspace folder'},

    {'<leader>w', proxy = '<c-w>', group = "Window"},
    {'<leader>k', vim.lsp.buf.hover, desc = 'Show docs for item under cursor'},
    {'<leader>r', vim.lsp.buf.rename, desc = 'Rename symbol'},
    {'<leader>?', whichkey.show, desc = 'Show keybinds'},

    {'g', name = 'Goto', group = 'Goto'},
    {'gg', desc = 'Goto line number <n> else file start'},
    {'gf', desc = 'Goto file in selection'},
    {'gh', desc = 'Goto line start'},
    {'gl', desc = 'Goto line end'},
    {'gs', desc = 'Goto first non-blank in line'},
    {'gd', tsbuiltin.lsp_definitions, desc = 'Goto definition'},
    {'gr', tsbuiltin.lsp_references, desc = 'Goto references'},
    {'gi', tsbuiltin.lsp_implementations, desc = 'Goto implementation'},
    {'gv', desc = 'Goto last visual selection'},
    {'gw', helix_flash_jump, desc = 'Jump to a two-character label'},
    {'gu', desc = 'Make lowercase in motion'},
    {'gU', desc = 'Make uppercase in motion'},
    {'g~', desc = 'Toggle case in motion'},
    {'g%', hidden = true},
    {'g;', hidden = true},
    {'g,', hidden = true},

    {'z<CR>', hidden = true},
})
