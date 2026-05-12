------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output = "eDP-1",
    mode = "2880x1800@120",
    position = "0x0",
    scale = 1.8,
    bitdepth = 10,
    cm = "dcip3",
    vrr = 1,
    supports_wide_color = 1,
    supports_hdr = 1,
    sdrbrightness = 1.2,
    sdrsaturation = 1,
    sdr_min_luminance = 0.0005,
    sdr_max_luminance = 80,
    min_luminance = 0.0005,
    max_luminance = 400,
})

-- hl.monitor({
--     output = "eDP-1",
--     mode = "2880x1800@120",
--     position = "0x0",
--     scale = 1.8,
--     icc = "/home/carl/.config/hypr/shaders/profile.icm",
--     bitdepth = 10,
-- })

hl.config({
    render = {
        cm_auto_hdr = 1,
        direct_scanout = true,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})
