local flash = require("flash")

vim.keymap.set({'n', 'v', 'o'}, 'gw', function()
    flash.jump({
        search = { mode = "search", max_length = 0 },
        label = { after = false, before = true },
        matcher = function(win)
          return require("flash.format").words(win)
        end,
    })
end)
