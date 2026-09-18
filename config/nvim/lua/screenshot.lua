local M = {}

M.config = {}

-- Send a mesasge to the user.
local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO, { title = "Screenshot" })
end

-- Take a screenshot.
function M.screenshot(name)
    if not name:match("%.png$") then
        name = name .. ".png"
    end

    -- Prepare the path.
    local dir = vim.fn.getcwd() .. "/images"
    vim.fn.mkdir(dir, "p")
    local path = dir .. "/" .. name
    local cmd = {"sh", "-c", 'sleep 1.0 && geo=$(slurp) && sleep 0.2 && grim -g "$geo" "$1"', "--", path}

    -- Run the command.
    vim.system(cmd, {}, function(result)
        vim.schedule(function()
            if result.code == 0 then
                notify("Screenshot saved: " .. path)
            elseif result.code == 1 then
                notify("Screenshot cancelled")
            else
                notify("grim failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
            end
        end)
    end)
end

-- Setup the plugin.
function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})
    vim.api.nvim_create_user_command("SS", function(opts)
        local args = opts.fargs
        M.screenshot(args[1])
    end, {nargs = "+"})
end

return M
