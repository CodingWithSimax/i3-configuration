local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local widget = require("user.wibar.widget")
local progressbar = require("user.wibar.progressbar")
local vicious = require("vicious")

local BATTERY_ID = "BAT1"

return function (s, height, color)
    local data = progressbar(s, color, height, 50)

    vicious.cache(vicious.widgets.volume)
    vicious.register(data.bar, vicious.widgets.bat,
        function (widget, args)
            data.text:set_text(args[1] .. " " .. args[2] .. "%")
            -- local gb = math.floor((args[2] / 1000 * 10) + 0.5) / 10
            -- bar:set_value(0.3)
            --
            return args[2]
        end,
        1, BATTERY_ID
    )

    return data.widget
end
