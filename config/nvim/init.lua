
-- Plugin Installation
vim.pack.add({
    'https://github.com/rebelot/kanagawa.nvim',           -- Cool colorscheme
    'https://github.com/rose-pine/neovim',                -- Other cool color scheme
    'https://github.com/folke/flash.nvim',                -- Helix-style word jump motions
    'https://github.com/folke/which-key.nvim',            -- Key mapping reference tool
    'https://github.com/folke/snacks.nvim',               -- A bunch of utilities
    'https://github.com/dgagn/diagflow.nvim',             -- Helix-style diagnostics
    'https://github.com/sindrets/diffview.nvim',          -- Tabbed diff view
    'https://github.com/nvim-treesitter/nvim-treesitter', -- Treesitter
    'https://github.com/neovim/nvim-lspconfig',           -- Sane LSP defaults
    'https://github.com/mason-org/mason.nvim.git',        -- LSP installation utility
})

local _ = require("utils")
local _ = require("lsp")

local flash = require("flash")
local diagflow = require("diagflow")
local diffview = require("diffview")
local treesitter = require("nvim-treesitter")
local mason = require("mason")
local snacks = require("snacks")
local whichkey = require("which-key")

----------------------------------------------------------------------
-- Generic
----------------------------------------------------------------------

vim.cmd[[colorscheme rose-pine]]
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "100"
vim.opt.guicursor = "a:block"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

----------------------------------------------------------------------
-- Plugins
----------------------------------------------------------------------

flash.setup({})
diffview.setup({})
diagflow.setup({})
treesitter.setup({})
mason.setup({})

snacks.setup({
    bigfile = { enabled = true },
    gh = { enabled = true },
    git = { enabled = true },
    indent = { enabled = true, scope = { enabled = false } },
    picker = { enabled = true, win = { input = { keys = { ["<Esc>"] = { "close", mode = "i" } }}}},
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    rename = { enabled = true },
    words = { enabled = true },
})

----------------------------------------------------------------------
-- Keybinds
----------------------------------------------------------------------

local _ = require("keymap")
whichkey.setup({preset="helix", icons={mappings=false}})
whichkey.add({
    {'<leader>', name = 'Space', group = 'Space'},
    {'<leader>w', proxy = '<c-w>', group = 'Window'},
    {'<leader>g', name = 'Git', group = 'Git'},
    {'<leader>s', name = 'Search', group = 'Search'},
    {'g', name = 'Goto', group = 'Goto'},
    {'z<CR>', hidden = true},
})

