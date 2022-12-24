local rofi = {}

local gears = require('gears')
local awful = require("awful")

function rofi.update_keys(globalkeys, mod)
	return gears.table.join(globalkeys,
        awful.key(
            {"Mod1"}, "space",
            function ()
                awful.util.spawn(os.getenv('HOME') .. '/.config/rofi/launchers/type-2/launcher.sh')
            end,
            {description="show help", group="awesome"}
        ),

        awful.key(
            {mod}, "l",
            function ()
                awful.util.spawn(os.getenv('HOME') .. '/.config/rofi/applets/bin/powermenu.sh')
            end,
            {description="show help", group="awesome"}
        ),

        awful.key(
            {mod}, "b",
            function ()
                awful.util.spawn(os.getenv('HOME') .. '/.config/rofi/applets/bin/brightness.sh')
            end,
            {description="show help", group="awesome"}
        ),

        awful.key(
            {}, "Print",
            function ()
                awful.util.spawn(os.getenv('HOME') .. '/.config/rofi/applets/bin/screenshot.sh')
            end,
            {description="show help", group="awesome"}
        )
    )
end

return rofi
