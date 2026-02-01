local setup = require('setup.debug')

return {
    -- Debug Adapter Protocol
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
    },
    -- Debug Adapter UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        event = "VeryLazy",
    },
    -- Help with running tests.
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
        event = "VeryLazy",
    }
}
