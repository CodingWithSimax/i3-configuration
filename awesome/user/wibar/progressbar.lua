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

return function (s, color, h, force_width)
    force_width = force_width or 100

    local colorRGB = hex2rgb(color)
    colorRGB[1] = math.max(0, colorRGB[1] - 30)
    colorRGB[2] = math.max(0, colorRGB[2] - 30)
    colorRGB[3] = math.max(0, colorRGB[3] - 30)

    local highlightedColor = rgb2hex(colorRGB[1], colorRGB[2], colorRGB[3])

    local m = h/2

    local text = wibox.widget {
        widget = wibox.widget.textbox,
    }
    local bar = wibox.widget {
        -- widget,
        forced_width = force_width,
        forced_height = h,
        max_value = 1,
        value = 0.50,

        widget = wibox.widget.progressbar,
        shape = gears.shape.transform(function (cr, width, height)
            gears.shape.powerline(cr, width, height, -m)
        end),

        background_color = color,
        color = highlightedColor
    }

    local w = wibox.widget {
        bar,
        {
            text,
            widget = wibox.container.margin,
            left = m,
            right = m + margin
        },

        layout = wibox.layout.stack
    }

    return {
        widget = w,
        bar = bar,
        text = text
    }
end
