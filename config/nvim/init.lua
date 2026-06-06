
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

-- Generic Configuration
vim.cmd[[colorscheme kanagawa]]
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true

-- Helpful picker to mimic the helix current file file picker
local function find_files_relative()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == "" then
    tsbuiltin.find_files()
    return
  end

  local current_dir = vim.fs.dirname(current_file)
  tsbuiltin.find_files({
    cwd = current_dir,
    prompt_title = "Find Files (Relative: " .. vim.fs.basename(current_dir) .. ")",
  })
end

-- Vim Keybind Configuration
vim.keymap.set({'n', 'v'}, 'ge', 'G', { desc = 'Last line' });
vim.keymap.set({'n', 'v'}, 'gl', '$', { desc = 'End of line' });
vim.keymap.set({'n', 'v'}, 'gh', '0', { desc = 'Beginning of line' });
vim.keymap.set('n', '<leader>c', 'gcc', { remap = true, desc = 'Toggle comment' });
vim.keymap.set('v', '<leader>c', 'gc', { remap = true, desc = 'Toggle comment selection' });
vim.keymap.set('v', '<leader>y', '"+y', { remap = true, desc = 'Yank selection to clipboard' });
vim.keymap.set({'n', 'v'}, '<leader>p', '"+y', { remap = true, desc = 'Paste clipboard after selection' });
vim.keymap.set({'n', 'v'}, '<leader>P', '"+y', { remap = true, desc = 'Paste clipboard before selection' });

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
})

-- Diagflow Diagnostic Configuration
local diagflow = require("diagflow")
diagflow.setup({
    scope = 'cursor',
    position = 'top_right',
})

-- Lsp Global Configuration
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Get the lsp client that attached
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- Enable autocompletion
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf)
    end
  end
})

-- Custom Lsp Configuration
vim.lsp.config('lua_ls', {settings = { Lua = { diagnostics = { globals = { 'vim' }}}}})
vim.lsp.enable({ 'clangd', 'lua_ls' })

