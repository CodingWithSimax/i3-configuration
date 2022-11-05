local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")


-- Keyboard map indicator and switcher

-- Create a textclock widget
-- mytextclock = wibox.widget.textclock()

local taglist = require('user.wibar.taglist')
local textclock = require('user.wibar.textclock')
local layoutbox = require('user.wibar.layoutbox')
local keyboard = require('user.wibar.keyboard')
local ram = require('user.wibar.ram')
local volume = require('user.wibar.volume')
local tray = require('user.wibar.tray')
local battery = require('user.wibar.battery')

local palette = require('themes.dracula.palette')

return function (s)
    local height = 30
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = height,

        bg = palette.background
        -- border_color = "#44475a",
        -- bg = "#282a36"
    })

    s.mytaglist = taglist(s)

    -- local tray = ni
    -- if not loaded then
    --     tray = wibox.widget.systray()
    --     tray:set_screen(s)
    -- end

    -- tray:set_base_size(50)
    -- tray:setup {}


    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            {
                left  = 7,
                widget = wibox.container.margin,
            },
            s.mytaglist,
            s.mypromptbox,
        },
        nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            keyboard(s, height, palette.cyan),
            volume(s, palette.purple, height),
            ram(s, palette.red, height),
            textclock(s, height, palette.yellow),
            battery(s, height, palette.orange),
            {
                layout = awful.widget.only_on_screen,
                tray(s, height, palette.background),
                screen = "primary"
            },
            layoutbox(s, palette.red, height),
        },
    }
end
