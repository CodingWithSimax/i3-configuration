local rofi = {}

local gears = require('gears')
local awful = require("awful")

function rofi.update_keys(globalkeys)
	return gears.table.join(globalkeys,
        awful.key(
            {"Mod1"}, "space",
            function ()
                awful.util.spawn(os.getenv('HOME') .. '/.config/rofi/launchers/type-2/launcher.sh')
            end,
            {description="show help", group="awesome"}
        )
    )
end

return rofi
