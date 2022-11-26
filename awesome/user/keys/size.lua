local gears = require("gears")
local awful = require("awful")

local steps = 50

return {
    update_keys = function (globalkeys, mod)
        return gears.table.join(globalkeys,
            awful.key(
                {mod}, "Right",
                function ()
                    local c = client.focus
                    if c then
                        c.width = c.width + steps
                    end
                end,
                {description="show help", group="awesome"}
            ),
            awful.key(
                {mod}, "Left",
                function ()
                    local c = client.focus
                    if c then
                        c.width = c.width - steps
                    end
                end,
                {description="show help", group="awesome"}
            ),


            awful.key(
                {mod}, "Up",
                function ()
                    local c = client.focus
                    if c then
                        c.height = c.height - steps
                    end
                end,
                {description="show help", group="awesome"}
            ),
            awful.key(
                {mod}, "Down",
                function ()
                    local c = client.focus
                    if c then
                        c.height = c.height + steps
                    end
                end,
                {description="show help", group="awesome"}
            ),

            -- move
            awful.key(
                {mod, "Shift"}, "Right",
                function ()
                    local c = client.focus
                    if c then
                        c.x = c.x + steps
                    end
                end,
                {description="show help", group="awesome"}
            ),
            awful.key(
                {mod, "Shift"}, "Left",
                function ()
                    local c = client.focus
                    if c then
                        c.x = c.x - steps
                    end
                end,
                {description="show help", group="awesome"}
            ),


            awful.key(
                {mod, "Shift"}, "Up",
                function ()
                    local c = client.focus
                    if c then
                        c.y = c.y - steps
                    end
                end,
                {description="show help", group="awesome"}
            ),
            awful.key(
                {mod, "Shift"}, "Down",
                function ()
                    local c = client.focus
                    if c then
                        c.y = c.y + steps
                    end
                end,
                {description="show help", group="awesome"}
            ),

            awful.key(
                {mod}, "f",
                function ()
                    local c = client.focus
                    if c then
                        local area = c.screen.workarea
                        c.x = area.x
                        c.y = area.y
                        c.width = area.width
                        c.height = area.height
                    end
                end,
                {description="show help", group="awesome"}
            )
        )
    end
}

