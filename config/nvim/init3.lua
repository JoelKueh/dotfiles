
-- Plugin Installation
vim.pack.add({
  --'https://github.com/nvim-tree/nvim-web-devicons',
  --'https://github.com/stevearc/dressing.nvim',
  'https://github.com/folke/flash.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/rhysd/git-messenger.vim',
})

-- Generic Configuration
vim.cmd[[colorscheme kanagawa]]

-- Which Key Configuration
local wk = require("which-key")
wk.setup({preset = "helix"})
wk.add({
  { "<leader>f", group "file/find" },
})

-- Telescope Configuration
local telescope = require("telescope")
local tsbuiltin = telescope.builtin
vim.keymap.set('nv', '<leader>f', tsbuiltin.find_files, { desc = 'Pick File' })
--vim.keymap.set('n', '<leader>e', vim.cmd.
vim.keymap.set('nv', '<leader>b', tsbuiltin.buffers, { desc = 'Pick Buffer' })
vim.keymap.set('nv', '<leader>/', tsbuiltin.live_grep, { desc = 'Live Grep' })
vim.keymap.set('nv', '<leader>gf', tsbuiltin.git_files, { desc = 'Pick Git File' })

-- Lsp Global Configuration
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Get the lsp client that attached
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- Enable autocompletion as you type
    if client.supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end
})

-- Custom Lsp Configuration
vim.lsp.config('clangd', { cmd = { 'clangd' }})
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' }
  root_markers = { '.luarc.json', '.git' }
  settings = { Lua = { diagnostics = { globals = { 'vim' }}}}
})
vim.lsp.enable({ 'clangd', 'lua_ls' })

