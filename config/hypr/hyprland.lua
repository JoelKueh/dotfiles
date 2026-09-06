
-- Autostart Noctalia
hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
end)

-- Source files
require("variables")
require("appearance")
require("keybinds")
require("devices")

-- Maxsize Rule
local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- For Noctalia Color templates
require("noctalia").apply_theme()
