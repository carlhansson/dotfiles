---------------------
---- KEYBINDINGS ----
---------------------

local vars = require("modules.variables")
local mod = "SUPER"
local ipc = "qs -c noctalia-shell ipc call"
local terminal = "foot"
local fileManager = "dolphin"

-- 1. Applications
hl.bind(mod .. " + Q", hl.dsp.exec_cmd(vars.app(terminal)))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(vars.app(fileManager)))
hl.bind(mod .. " + K", hl.dsp.exec_cmd(vars.app(terminal .. " --app-id=qalc-float -e qalc")))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(ipc .. " launcher toggle"))
hl.bind(mod .. " + X", hl.dsp.exec_cmd(ipc .. " launcher clipboard"))
hl.bind(mod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("rofi-rbw"))

-- 2. Window management
hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + LEFT", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + RIGHT", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + UP", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + DOWN", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + SHIFT + LEFT", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + RIGHT", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + UP", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + DOWN", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- 3. Workspaces
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
-- Special workspace (scratchpad)
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- 4. System
hl.bind(mod .. " + M", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mod .. " + L", hl.dsp.exec_cmd(ipc .. " lockScreen lock"))
hl.bind(mod .. " + comma", hl.dsp.exec_cmd(ipc .. " settings toggle"))

-- 5. Panels & Shell
hl.bind(mod .. " + W", hl.dsp.exec_cmd(ipc .. " wallpaper toggle"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd(ipc .. " network togglePanel"))
hl.bind(mod .. " + P", hl.dsp.exec_cmd(ipc .. " plugin openPanel network-manager-vpn"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(ipc .. " bluetooth togglePanel"))
hl.bind(mod .. " + SHIFT + K", hl.dsp.exec_cmd(ipc .. " plugin:keybind-cheatsheet toggle"))

-- 6. Media
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume increase"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume decrease"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume muteOutput"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. " volume muteInput"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness increase"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness decrease"),
    { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),
    { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true, repeating = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),
    { locked = true })

-- 7. Screenshots
hl.bind(mod .. " + PRINT", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind(mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/$(date +'%s_grim.png')"))

-- 8. Display
hl.bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd("hyprctl keyword monitor \"HDMI-A-1,preferred,auto,1,mirror,eDP-1\""))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("hyprctl keyword monitor \"HDMI-A-1,preferred,auto,1\""))
