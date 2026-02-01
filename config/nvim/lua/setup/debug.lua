
local M = {}

function M.setup_dapui()
    local dap, dapui = require('dap'), require('dapui')
    dap.listen.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listen.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listen.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listen.before.event_exited.dapui_config = function()
        dapui.close()
    end
end
