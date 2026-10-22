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

vim.lsp.config('svlangserver' ,{
    settings = {
        systemverilog = {
            includeIndexing = { "**/*.{sv,svh}" },
            excludeIndexing = { "test/**/*.sv*" },

            includePaths = {
              os.getenv("UVM_HOME") and (os.getenv("UVM_HOME") .. "/src"),
              os.getenv("SVUNIT_INSTALL") and (os.getenv("SVUNIT_INSTALL") .. "/src"),
              "./include"
            },

            defines = {
              "UVM_NO_DEPRECATED"
            },

            launchConfiguration = "verilator -sv --lint-only -Wall"
        },
    },
})

vim.lsp.enable({
    'clangd',
    'lua_ls',
    'svlangserver',
    'bashls',
    'zls',
    'rust_analyzer',
    'pyright',
    'tinymist',
    'mpls',
})
