local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

return function (s)
    local focused = false

    local function update()
        focused = awful.screen.focused().index == s.index
    end

    client.connect_signal("focus", function (c) update() end)

    local widget = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        style   = {
            shape = function (cr, w, h)
                if focused then
                    gears.shape.partially_rounded_rect(cr, w, 2, true, true, true, true, 0)
                else
                    local circleSize = 5
                    local fun = gears.shape.transform(function (cr, w, h)
                        gears.shape.circle(cr, circleSize, circleSize)
                    end):translate((w-circleSize)/2,-circleSize/2)
                    fun(cr, w, h)
                end
            end
        },
        layout   = {
            spacing = 0,
            spacing_widget = {
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
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 14,
                right = 14,
                widget = wibox.container.margin,
            },
            id     = 'background_role',
            -- bg = "#ff0000",
            -- shape = function (cr, w, h)
            --     gears.shape.partially_rounded_rect(cr, w, 2, true, true, true, true, 0)
            -- end,
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
        }
    }

    return widget
end
