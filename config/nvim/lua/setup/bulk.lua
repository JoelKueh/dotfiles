
local M = {}

function M.setup_dashboard()
    require('dashboard').setup {
        -- config
    }
end

function M.opts_lualine()
    local lualine = require("lualine_require")

    return {}
end

return M

