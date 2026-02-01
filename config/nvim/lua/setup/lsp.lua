
local M = {}

local function map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
end

local function setup_clangd()
    vim.lsp.config('clangd', {})
    vim.lsp.enable('clangd')
end

local function setup_lua_ls()
    vim.lsp.config('lua_ls', {
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path..'/.luarc.json')
                or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                return
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT'
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                }
            })
        end,
        settings = {
            Lua = {}
        }
    })
    vim.lsp.enable('lua_ls')
end

local function setup_verible()
    vim.lsp.config('verible', {
        cmd = {
            "verible-verilog-ls",
            "--rules_config_search",
        }
    })
    vim.lsp.enable('verible')
end

function M.setup_lsp()
    local mason = require("mason")
    local masonconf = require("mason-lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities,
        require('cmp_nvim_lsp').default_capabilities())

    -- Setup mason and install various language server.
    mason.setup()
    masonconf.setup({
        ensure_installed = {
            "pyright",
            "clangd",
            "ltex",
            "verible",
            "lua_ls",
            "rust_analyzer"
        }
    })

    -- Helpers for complex setups.
    setup_clangd()
    setup_lua_ls()
    setup_verible()

    -- Simple one line setups.
    vim.lsp.enable('rust_analyzer')
    vim.lsp.enable('cmake')
    vim.lsp.enable('gdscript')
    vim.lsp.enable('csharp_ls')
    vim.lsp.enable('matlab_ls')
    vim.lsp.enable('jdtls')
    vim.lsp.enable('pyright')
    vim.lsp.enable('ltex')
    vim.lsp.enable('alloy_ls')

    -- Keybinds
    map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
    map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
    map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
    map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
    map('n','<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>')
    map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
end

function M.setup_cmp()
    local cmp = require("cmp")

    vim.opt.completeopt = { "menu", "menuone" }

    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.boxy)
            end,
        },
        window = {

        },
        mapping = cmp.mapping.preset.insert({
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
        }
    })
end

return M
