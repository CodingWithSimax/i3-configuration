local gears = require('gears')
local awful = require("awful")

return {
    update_keys = function (globalkeys, modkey)

        return gears.table.join(globalkeys,
            awful.key(
                {modkey, "Control"}, "Return",
                function ()
                    awful.util.spawn("neovide")
                end,
                {description="show help", group="awesome"}
            )
        )
    end
}
