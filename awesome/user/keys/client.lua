local clientkeys = {}

local gears = require('gears')
local awful = require("awful")

function clientkeys.update_keys(globalkeys, modkey)
	return gears.table.join(globalkeys,
        awful.key(
            {modkey}, "d",
            function ()
                awful.client.focus.global_bydirection("right")
            end,
            {description="client movement", group="awesome"}
        ),
        awful.key(
            {modkey}, "a",
            function ()
                awful.client.focus.global_bydirection("left")
            end,
            {description="client movement", group="awesome"}
        ),
        awful.key(
            {modkey}, "w",
            function ()
                awful.client.focus.global_bydirection("up")
            end,
            {description="client movement", group="awesome"}
        ),
        awful.key(
            {modkey}, "s",
            function ()
                awful.client.focus.global_bydirection("down")
            end,
            {description="client movement", group="awesome"}
        )
    )
end

return clientkeys
