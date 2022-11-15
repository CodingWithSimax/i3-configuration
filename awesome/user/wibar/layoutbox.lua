local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local palette = require("themes.dracula.palette")
local widget = require("user.wibar.widget")

return function (s, color, h)
    local mylayoutbox = awful.widget.layoutbox(s)
    mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    return wibox.widget {
        mylayoutbox,
        widget = wibox.container.margin,
        right = 4,
        left = 4
    }
    -- return widget(mylayoutbox, color, h, true)

    -- return wibox.widget {
    --     -- widget,
    --     mylayoutbox,
    --     widget = wibox.container.background,
    --     shape = gears.shape.transform(function (cr, width, height)
    --         gears.shape.partially_rounded_rect(cr, width, height)
    --     end),
    --
    --     bg = color,
    --     fg = palette.current_line


end
