local flash = require("flash")

-- Mimic the helix goto word motion
function helix_flash_jump()
    vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#ff9e64", bold = true, bg = "NONE" })
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ff9e64", bold = true, bg = "NONE" })

    local function format(opts)
        return {
            { opts.match.label1, "FlashMatch" },
            { opts.match.label2, "FlashLabel" },
        }
    end

    flash.jump({
        search = { mode = "search" },
        label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
        pattern = [[\<]],
        action = function(match, state)
            state:hide()
            flash.jump({
                search = { max_length = 0 },
                highlight = { matches = false },
                label = { format = format },
                matcher = function(win)
                    -- limit matches to the current label
                    return vim.tbl_filter(function(m)
                        return m.label == match.label and m.win == win
                    end, state.results)
                end,
                labeler = function(matches)
                    for _, m in ipairs(matches) do
                        m.label = m.label2 -- use the second label
                    end
                end,
            })
        end,
        labeler = function(matches, state)
            local labels = state:labels()
            for m, match in ipairs(matches) do
                match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                match.label2 = labels[(m - 1) % #labels + 1]
                match.label = match.label1
            end
        end,
    })
end

-- Take a screenshot.
function screenshot(name)
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
                vim.notify("Screenshot saved: " .. path, vim.log.levels.INFO)
            elseif result.code == 1 then
                vim.notify("Screenshot cancelled", vim.log.levels.INFO)
            else
                vim.notify("grim failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
            end
        end)
    end)
end

-- Register Commands
vim.api.nvim_create_user_command("SS", function(opts)
    local args = opts.fargs
    screenshot(args[1])
end, {nargs = 1, desc = "Takes a screenshot and saves it to <PWD>/images/NAME.png"})
