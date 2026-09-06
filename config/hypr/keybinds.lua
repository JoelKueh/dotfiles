local vars = require("variables")

-- =============================================================================
-- Moving
-- =============================================================================

-- Focus
hl.bind(vars.mainMod .. " + H",  hl.dsp.focus({ direction = "l" }))
hl.bind(vars.mainMod .. " + J",  hl.dsp.focus({ direction = "d" }))
hl.bind(vars.mainMod .. " + K",    hl.dsp.focus({ direction = "u" }))
hl.bind(vars.mainMod .. " + L", hl.dsp.focus({ direction = "r" }))

-- Move windows
hl.bind(vars.mainMod .. " + SHIFT + LEFT", hl.dsp.window.move({ direction = "l" }))
hl.bind(vars.mainMod .. " + SHIFT + DOWN", hl.dsp.window.move({ direction = "d" }))
hl.bind(vars.mainMod .. " + SHIFT + UP", hl.dsp.window.move({ direction = "u" }))
hl.bind(vars.mainMod .. " + SHIFT + RIGHT", hl.dsp.window.move({ direction = "r" }))
hl.bind(vars.mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(vars.mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(vars.mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(vars.mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

-- =============================================================================
-- Workspaces
-- =============================================================================

-- Switch to workspace
hl.bind(vars.mainMod .. " + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind(vars.mainMod .. " + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind(vars.mainMod .. " + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind(vars.mainMod .. " + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind(vars.mainMod .. " + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind(vars.mainMod .. " + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind(vars.mainMod .. " + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind(vars.mainMod .. " + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind(vars.mainMod .. " + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind(vars.mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))

-- Move window to workspace
hl.bind(vars.mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind(vars.mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind(vars.mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind(vars.mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind(vars.mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind(vars.mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind(vars.mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind(vars.mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind(vars.mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))
hl.bind(vars.mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- =============================================================================
-- Layout
-- =============================================================================

hl.bind(vars.mainMod .. " + B", hl.dsp.layout("togglesplit"))
hl.bind(vars.mainMod .. " + V", hl.dsp.layout("togglesplit"))
hl.bind(vars.mainMod .. " + W", hl.dsp.group.toggle())
hl.bind(vars.mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(vars.mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(vars.mainMod .. " + SPACE", hl.dsp.window.cycle_next())

-- =============================================================================
-- Scratchpad
-- =============================================================================

hl.bind(vars.mainMod .. " + SHIFT + MINUS", hl.dsp.window.move({ workspace = "special:scratchpad"}))
hl.bind(vars.mainMod .. " + MINUS", hl.dsp.workspace.toggle_special("scratchpad"))

-- =============================================================================
-- Execs
-- =============================================================================

hl.bind(vars.mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(vars.mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(vars.mainMod .. " + RETURN", hl.dsp.exec_cmd(vars.terminal))
hl.bind(vars.mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(vars.mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with vars.mainMod + arrow keys
hl.bind(vars.mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(vars.mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(vars.mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(vars.mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Scroll through existing workspaces with vars.mainMod + scroll
hl.bind(vars.mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(vars.mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with vars.mainMod + LMB/RMB and dragging
hl.bind(vars.mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(vars.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- =============================================================================
-- Noctalia
-- =============================================================================

-- Launchers
hl.bind(vars.mainMod .. " + I", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(vars.mainMod .. " + O", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(vars.mainMod .. " + P", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
hl.bind(vars.mainMod .. " + N", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center notifications"))
hl.bind(vars.mainMod .. " + M", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center media"))
hl.bind(vars.mainMod .. " + C", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center calendar"))
hl.bind(vars.mainMod .. " + COMMA", hl.dsp.exec_cmd("noctalia msg settings-toggle"))

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("noctalia msg mic-mute"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("noctalia msg brightness-up"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"), { locked = true })

-- Media
hl.bind("XF86AudioPause",  hl.dsp.exec_cmd("noctalia msg media pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("noctalia msg media previous"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("noctalia msg media next"), { locked = true })
hl.bind(vars.mainMod .. " + bracketleft",  hl.dsp.exec_cmd("noctalia msg media previous-player"), { locked = true })
hl.bind(vars.mainMod .. " + bracketright",  hl.dsp.exec_cmd("noctalia msg media next-player"), { locked = true })

-- Other
