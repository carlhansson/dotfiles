-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
local vars = require("modules.variables")

hl.on("hyprland.start", function()
    hl.exec_cmd(vars.app("qs -c noctalia-shell"))
end)

