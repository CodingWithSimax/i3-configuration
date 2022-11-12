local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local widget = require("user.wibar.widget")
local palette = require("themes.dracula.palette")

local margin = 5

local function hex2rgb(hex)
    hex = hex:gsub("#","")
    return {tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))}
end
local function rgb2hex(r, g, b)
    local rgb = (r * 0x10000) + (g * 0x100) + b
    return "#" .. string.format("%x", rgb)
end

return function (s, color, h, force_width, on_click)
    force_width = force_width or 100

    local m = h/2

    local text = wibox.widget {
        widget = wibox.widget.textbox
    }
    local bar_height = 4
    local bar = wibox.widget {
        -- widget,
        forced_width = force_width,
        forced_height = h,
        max_value = 1,
        value = 0.50,

        widget = wibox.widget.progressbar,
        shape = function (cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, bar_height, true, true, true, true, 0)
        end,
        bar_shape = function (cr, width, height)
            gears.shape.hexagon(cr, width, bar_height, bar_height/2)
        end,

        background_color = palette.background,
        color = color,
    }

    if on_click then
        bar:connect_signal("button::press", function (self, lx, ly, button, mods, find_widgets_result)
            local progress = lx / find_widgets_result.width
            on_click(progress)
            bar:set_value(progress)
        end)
    end

    local w = wibox.widget {
        bar,
        {
            {
                {
                    text,
                    widget = wibox.container.constraint,
                    width = 300
                },
                widget = wibox.container.background,
                fg = color
            },
            widget = wibox.container.margin,
            left = m,
            right = m
        },

        layout = wibox.layout.stack,
    }

    return {
        widget = w,
        bar = bar,
        text = text,
        set_hidden = function (state)
            if state then
                w.forced_width = 0
            else
                w.forced_width = nil
            end
        end
    }
end
