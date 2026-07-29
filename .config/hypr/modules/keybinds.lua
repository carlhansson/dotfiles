---------------------
---- KEYBINDINGS ----
---------------------
local vars = require("modules.variables")
local mod = "SUPER"
local ipc = "noctalia msg "
local terminal = "foot"
local fileManager = "yazi"

-- 1. Applications
hl.bind(mod .. " + Q", hl.dsp.exec_cmd(vars.app(terminal)), { description = "Terminal" })
hl.bind(mod .. " + E", hl.dsp.exec_cmd(vars.app(terminal .. " bash -c " .. fileManager)), { description = "File manager" })
hl.bind(mod .. " + K", hl.dsp.exec_cmd(vars.app(terminal .. " --app-id=qalc-float -e qalc")),
    { description = "Calculator" })
hl.bind(mod .. " + R", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"), { description = "App launcher" })
hl.bind(mod .. " + X", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"), { description = "Clipboard history" })
hl.bind(mod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("rofi-rbw"), { description = "Password manager" })

-- 2. Window management
hl.bind(mod .. " + C", hl.dsp.window.close(), { description = "Close window" })
hl.bind(mod .. " + F", hl.dsp.window.fullscreen(), { description = "Toggle fullscreen" })
hl.bind(mod .. " + LEFT", hl.dsp.window.move({ direction = "l" }), { description = "Move window left" })
hl.bind(mod .. " + RIGHT", hl.dsp.window.move({ direction = "r" }), { description = "Move window right" })
hl.bind(mod .. " + UP", hl.dsp.window.move({ direction = "u" }), { description = "Move window up" })
hl.bind(mod .. " + DOWN", hl.dsp.window.move({ direction = "d" }), { description = "Move window down" })
hl.bind(mod .. " + SHIFT + LEFT", hl.dsp.window.resize({ x = -50, y = 0, relative = true }),
    { repeating = true, description = "Resize window left" })
hl.bind(mod .. " + SHIFT + RIGHT", hl.dsp.window.resize({ x = 50, y = 0, relative = true }),
    { repeating = true, description = "Resize window right" })
hl.bind(mod .. " + SHIFT + UP", hl.dsp.window.resize({ x = 0, y = -50, relative = true }),
    { repeating = true, description = "Resize window up" })
hl.bind(mod .. " + SHIFT + DOWN", hl.dsp.window.resize({ x = 0, y = 50, relative = true }),
    { repeating = true, description = "Resize window down" })
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with mouse" })

-- 3. Workspaces
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Workspace " .. i })
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }),
        { description = "Move window to workspace " .. i })
end
-- Special workspace (scratchpad)
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle scratchpad" })
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }),
    { description = "Move window to scratchpad" })

-- 4. System
hl.bind(mod .. " + M", hl.dsp.exec_cmd("uwsm stop"), { description = "Logout / stop session" })
hl.bind(mod .. " + L", hl.dsp.exec_cmd(ipc .. "session lock"), { description = "Lock screen" })
hl.bind(mod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"), { description = "Open settings" })
hl.bind(mod .. " + SHIFT + P", hl.dsp.exec_cmd(ipc .. "panel-toggle session"), { description = "Open power menu" })

-- 5. Panels & Shell
hl.bind(mod .. " + W", hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"), { description = "Wallpaper picker" })
hl.bind(mod .. " + N", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center network"), { description = "Network panel" })
hl.bind(mod .. " + B", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center bluetooth"), { description = "Bluetooth panel" })
hl.bind(mod .. " + SHIFT + K", hl.dsp.exec_cmd(ipc .. "panel-toggle kenn/keybind-cheatsheet:cheatsheet"),
    { description = "Keybind cheatsheet" })

-- 6. Media
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"),
    { locked = true, repeating = true, description = "Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"),
    { locked = true, repeating = true, description = "Volume down" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"),
    { locked = true, repeating = true, description = "Mute output" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. "mic-mute"),
    { locked = true, repeating = true, description = "Mute microphone" })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"),
    { locked = true, repeating = true, description = "Brightness up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"),
    { locked = true, repeating = true, description = "Brightness down" })

-- 7. Screenshots
hl.bind(mod .. " + PRINT", hl.dsp.exec_cmd(ipc .. "screenshot-region"),
    { description = "Screenshot region to clipboard" })

-- 8. Display
hl.bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd("hyprctl keyword monitor \"HDMI-A-1,preferred,auto,1,mirror,eDP-1\""),
    { description = "Mirror HDMI to eDP" })
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("hyprctl keyword monitor \"HDMI-A-1,preferred,auto,1\""),
    { description = "Extend HDMI display" })
