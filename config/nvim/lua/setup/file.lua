
local M = {}

function M.setup_treesitter()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
        ensure_installed = {
            "c",
            "lua",
            "luadoc",
            "luap",
            "vim",
            "vimdoc",
            "query",
            "javascript",
            "html",
            "markdown",
            "markdown_inline",
            "bash",
            "diff",
            "jsdoc",
            "json",
            "jsonc",
            "printf",
            "python",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "xml",
            "yaml",
            "latex"
        },
        disable = {
            "verilog",
            "systemverilog"
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            move = {
                enable = true,
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                    ["]a"] = "@parameter.inner"
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                    ["]A"] = "@parameter.inner"
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                    ["[a"] = "@parameter.inner"
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[C"] = "@class.outer",
                    ["[A"] = "@parameter.inner"
                },
            },
        },
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    })
end

function M.setup_telescope()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    telescope.load_extension("undo")

    telescope.setup({
        defaults = {
            preview = { treesitter = false },
            color_devicons = true,
            sorting_strategy = "ascending",
            borderchars = {
                "─", -- top
                "│", -- right
                "─", -- bottom
                "│", -- left
                "┌", -- top-left
                "┐", -- top-right
                "┘", -- bottom-right
                "└", -- bottom-left
            },
            path_displays = { "smart" },
            layout_config = {
                height = 100,
                width = 400,
                prompt_position = "top",
                preview_cutoff = 40,
            }
        }
    })
end

function M.attach_gitsigns(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end

    -- stylua: ignore start
    map("n", "]h", function()
        if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
        else
            gs.nav_hunk("next")
        end
    end, "Next Hunk")
    map("n", "[h", function()
        if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
        else
            gs.nav_hunk("prev")
        end
    end, "Prev Hunk")
    map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
    map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
    map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
    map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
    map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
    map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
    map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
    map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
    map("n", "<leader>ghd", gs.diffthis, "Diff This")
    map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
end

return M
