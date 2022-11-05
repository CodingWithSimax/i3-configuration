local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local palette = require("themes.dracula.palette")

local margin = 5

return function (w, color, h, right_background)
    local m = h/2

    local right_margin = m + margin

    if right_background then
        right_margin = margin
    end

    return wibox.widget {
        -- widget,
        {
            w,
            widget = wibox.container.margin,
            left = m,
            right = right_margin
        },

        widget = wibox.container.background,
        shape = gears.shape.transform(function (cr, width, height)
            if right_background then
                gears.shape.rectangular_tag(cr, width, height, m)
            else
                gears.shape.powerline(cr, width, height, -m)
            end
        end),

        bg = color,
        fg = palette.current_line

    }
end
