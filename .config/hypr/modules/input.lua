-- Input configuration
hl.config({
    input = {
        kb_layout = "se",
        follow_mouse = 1,
        sensitivity = 0,
        repeat_rate = 40,
        repeat_delay = 500,
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.25,
            tap_to_click = false,
            clickfinger_behavior = true,
            disable_while_typing = false,
        },
    }
})


-- Disable trackpoint button
hl.device({
    name = "tpps/2-elan-trackpoint",
    enabled = false
})
