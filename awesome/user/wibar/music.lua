local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local widget = require("user.wibar.widget")
local palette = require("themes.dracula.palette")
local progressbar = require("user.wibar.progressbar")
local vicious = require("vicious")
local spawn = require('vicious.spawn')
local helpers = require('vicious.helpers')

local libFunction = {
    async = function (format, warg, callback)
        local formattedString = ""

        local output1 = ' {{ title }} - {{ artist }}'
        local output2 = '{{ position / mpris:length * 100 }}'
        local output3 = '{{ status }}'

        local count = 0
        local progress = 0
        local playing = false

        spawn.with_line_callback_with_shell('playerctl metadata --format "' .. output1 .. "\n" .. output2 .. "\n" .. output3 .. '"', {
            stdout = function (line)
                count = count + 1
                if count == 1 then
                    formattedString = line
                elseif count == 2 then
                    progress = math.floor(tonumber(line))
                elseif count == 3 and line == "Playing" then
                    playing = true
                end
            end,
            output_done = function ()
                callback({
                    Progress = progress,
                    State = formattedString,
                    playing = playing
                })
            end
        })
    end
}
local lib = helpers.setasyncall(libFunction)

return function (s, color, h)
    local data = progressbar(s, color, h)

    vicious.cache(vicious.widgets.volume)
    vicious.register(data.bar, lib,
        function (widget, args)
            data.text:set_text(args.State)
            data.set_hidden(not args.playing)
            -- local gb = math.floor((args[2] / 1000 * 10) + 0.5) / 10
            -- bar:set_value(0.3)
            --
            return args.Progress
        end,
        4
    )

    return data.widget
end
