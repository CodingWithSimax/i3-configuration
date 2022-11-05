local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")


        -- c.shape = function (cr, w, h)
        --     gears.shape.rounded_rect(cr, w, h, 8)
        -- end

return function (s)
    return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        style   = {
            -- fg_focus = "#ff0000",
            shape = function (cr, w, h)
                -- gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, 0)
                gears.shape.partially_rounded_rect(cr, w, 2, true, true, true, true, 0)
            end
        },
        layout   = {
            spacing = 0,
            spacing_widget = {
                -- color  = '#000000',
                shape  = gears.shape.rounded_rect,
                widget = wibox.widget.separator,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'text_role',
                            widget = wibox.widget.textbox
                        },
                        margins = 0,
                        widget  = wibox.container.margin,
                        -- bg = "#ff0000"
                        --
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 14,
                right = 14,
                widget = wibox.container.margin,
            },
            id     = 'background_role',
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
        },
        -- buttons = taglist_buttons
    }
end
