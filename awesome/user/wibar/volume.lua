local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local widget = require("user.wibar.widget")
local palette = require("themes.dracula.palette")
local progressbar = require("user.wibar.progressbar")
local vicious = require("vicious")

return function (s, color, h)
    local data = progressbar(s, color, h, nil, function (progress)
        awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ " .. math.floor(progress*100) .. "%", false)
    end)

    vicious.cache(vicious.widgets.volume)
    vicious.register(data.bar, vicious.widgets.volume,
        function (widget, args)
 -- gears.shape.partially_rounded_rect(cr, w, 2, true, true, true, true, 0)           
            data.text:set_text("Volume: " .. args[1] .. "%")
            -- data.text:set_text("Hallo")
            -- local gb = math.floor((args[2] / 1000 * 10) + 0.5) / 10
            -- bar:set_value(0.3)
            --
            return args[1]
        end,
        1, {"Master"}
    )

    return data.widget
end
