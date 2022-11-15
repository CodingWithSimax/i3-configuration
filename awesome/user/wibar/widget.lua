local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local palette = require("themes.dracula.palette")

local margin = 5

return function (w, color, h, right_background)
    local m = 2

    local right_margin = m + margin

    if right_background then
        right_margin = margin
    end

    return wibox.widget {
        {
            -- widget,
            {
                w,
                widget = wibox.container.margin,
                left = m,
                right = m
            },
            -- w,

            widget = wibox.container.background,

            shape = function (cr, w, h)
                gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 5)
            end,
            shape_clip = true,
            shape_border_width = 1,
            shape_border_color = palette.current_line_bright,
            -- shape = gears.shape.transform(function (cr, width, height)
            --     if right_background then
            --         gears.shape.rectangular_tag(cr, width, height, m)
            --     else
            --         gears.shape.powerline(cr, width, height, -m)
            --     end
            -- end),

            -- bg = color,
            fg = color
        },
        widget = wibox.container.margin,
        left = 4,
        right = 4

    }
end
