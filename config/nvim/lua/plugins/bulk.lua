local setup = require('setup.bulk')

return {
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "stevearc/dressing.nvim", event = "VeryLazy" },
    -- which-key
    {
        "folke/which-key.nvim",
        opts = {
            plugins = { spelling = true },
            delay = 0,
            defaults = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["gs"] = { name = "+surround" },
                --["z"] = { name = "+fold" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                --["<leader><tab>"] = { name = "+tabs" },
                --["<leader>b"] = { name = "+buffer" },
                --["<leader>c"] = { name = "+code" },
                ["<leader>p"] = { name = "+pick/find" },
                ["<leader>py"] = { name = "+pick/symbols" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gh"] = { name = "+hunks", ["_"] = "which_key_ignore" },
                --["<leader>q"] = { name = "+quit/session" },
                --["<leader>s"] = { name = "+search" },
                --["<leader>u"] = { name = "+ui" },
                --["<leader>w"] = { name = "+windows" },
                --["<leader>x"] = { name = "+diagnostics/quickfix" },
            },
        }
    },
}

