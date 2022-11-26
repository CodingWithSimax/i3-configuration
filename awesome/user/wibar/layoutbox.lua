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

    return widget({
        mylayoutbox,
        widget = wibox.container.margin,
        margins = 2
    }, palette.current_line, h, false)
end
