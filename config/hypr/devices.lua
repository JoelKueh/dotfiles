
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.monitor({ output = "DP-1", mode = "highrr", position = "1920x0", scale = 1 })
hl.monitor({ output = "DP-2", mode = "highrr", position = "0x0", scale = 1 })
