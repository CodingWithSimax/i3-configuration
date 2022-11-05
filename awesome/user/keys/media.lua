local clientkeys = {}

local gears = require('gears')
local awful = require("awful")

function clientkeys.update_keys(globalkeys, modkey)
	return gears.table.join(globalkeys,
        awful.key(
            {}, "XF86AudioRaiseVolume",
            function ()
                awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%")
            end,
            {description="client movement", group="awesome"}
        ),
        awful.key(
            {}, "XF86AudioLowerVolume",
            function ()
                awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%")
            end,
            {description="client movement", group="awesome"}
        ),
        awful.key(
            {}, "XF86AudioMute",
            function ()
                awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
            end,
            {description="client movement", group="awesome"}
        ),

        awful.key(
            {}, "XF86AudioPlay",
            function ()
                awful.util.spawn("playerctl play-pause")
            end,
            {description="client movement", group="awesome"}
        ),
        awful.key(
            {}, "XF86AudioNext",
            function ()
                awful.util.spawn("playerctl next")
            end,
            {description="client movement", group="awesome"}
        ),
        awful.key(
            {}, "XF86AudioPrev",
            function ()
                awful.util.spawn("playerctl previous")
            end,
            {description="client movement", group="awesome"}
        )
    )
end

return clientkeys
