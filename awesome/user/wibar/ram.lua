local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local widget = require("user.wibar.widget")
local palette = require("themes.dracula.palette")
local progressbar = require("user.wibar.progressbar")
local vicious = require("vicious")

return function (s, color, h)
    local data = progressbar(s, color, h)

    vicious.cache(vicious.widgets.mem)
    vicious.register(data.bar, vicious.widgets.mem,
        function (widget, args)
            local gb = math.floor((args[2] / 1000 * 10) + 0.5) / 10
            data.text:set_text("RAM: " .. gb .. "GB")
            -- bar:set_value(0.3)
            --
            return args[1]
        end,
        5
    )

    return data.widget
end
