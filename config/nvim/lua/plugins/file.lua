local setup = require('setup.file')

return {
    -- nvim-treesitter
    --{
    --    "nvim-treesitter/nvim-treesitter",
    --    build = function()
    --        require("nvim-treesitter.install").update({ with_sync = true })()
    --    end,
    --    config = setup.setup_treesitter,
    --},
    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'debugloop/telescope-undo.nvim',
        },
        keys = {
            { '<leader>pf', '<cmd>Telescope find_files<cr>', { desc='Telescope find files' }},
            { '<leader>ps', '<cmd>Telescope live_grep<cr>', { desc='Telescope live grep' }},
            { '<leader>pb', '<cmd>Telescope find_files<cr>', { desc='Telescope open buffers' }},

            { '<leader>pe', '<cmd>Telescope diagnostics<cr>', { desc='Telescope lsp diagnostics' }},
            { '<leader>pr', '<cmd>Telescope lsp_references<cr>', { desc='Telescope lsp references' }},
            { '<leader>pi', '<cmd>Telescope lsp_incoming_calls<cr>', { desc='Telescope lsp incoming calls' }},
            { '<leader>po', '<cmd>Telescope lsp_outgoing_calls<cr>', { desc='Telescope lsp outgoing calls' }},
            { '<leader>pd', '<cmd>Telescope lsp_document_symbols<cr>', { desc='Telescope lsp document symbols' }},
            { '<leader>pw', '<cmd>Telescope lsp_workspace_symbols<cr>', { desc='Telescope lsp workspace symbols' }},

            { '<leader>pc', '<cmd>Telescope colorscheme<cr>', { desc='Telescope colorscheme' }},
            { '<leader>pu', '<cmd>Telescope undotree<cr>', { desc='Telescope undo' }},
            { '<leader>pt', '<cmd>TodoTelescope<cr>', { desc='Telescope todo' }},

            { '<leader>gf', '<cmd>Telescope git_files<cr>', { desc='Telescope git files' }},
            { '<leader>gc', '<cmd>Telescope git_commits<cr>', { desc='Telescope git commits' }},
            { '<leader>gs', '<cmd>Telescope git_stash<cr>', { desc='Telescope git stash' }},
            { '<leader>gb', '<cmd>Telescope git_branches<cr>', { desc='Telescope git branches' }},
            { '<leader>gt', '<cmd>Telescope git_status<cr>', { desc='Telescope git status' }},
        },
        config = setup.setup_telescope,
        lazy = true,
    },
    -- gitsigns
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            on_attach = setup.attach_gitsigns,
        },
        event = "VeryLazy",
    },
    -- git-messenger
    {
        'rhysd/git-messenger.vim',
        event = "VeryLazy",
    },
    -- todo-comments
    {
        'folke/todo-comments.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        opts = {},
        event = "VeryLazy",
    }
}
