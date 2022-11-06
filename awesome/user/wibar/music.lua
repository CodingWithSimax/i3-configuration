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

return function (s, color, h)

    local max_time = 10
    local old_playing = false

    local not_playing = 10

    local show_player = false

    local libFunction = {
        async = function (format, warg, callback)
            local formattedString = ""

            local output1 = ' {{ title }} - {{ artist }}'

            if show_player then
                output1 = '  {{ playerName }}'
                show_player = false
            end

            local output2 = '{{ position / mpris:length * 100 }}'
            local output3 = '{{ status }}'
            local output4 = '{{ mpris:length / 1000 / 1000 }}'

            local count = 0
            local progress = 0
            local playing = false


            spawn.with_line_callback_with_shell('playerctl metadata --format "' .. output1 .. "\n" .. output2 .. "\n" .. output3 .. "\n" .. output4 .. '"', {
                stdout = function (line)
                    count = count + 1
                    if count == 1 then
                        formattedString = line
                    elseif count == 2 then
                        local result = tonumber(line)
                        if result ~= nil then
                            progress = math.floor(result)
                        end
                    elseif count == 3 and line == "Playing" then
                        playing = true
                        not_playing = 0
                    elseif count == 4 then
                        local result = tonumber(line)
                        if result ~= nil then
                            max_time = math.floor(result)
                        end
                    end
                end,
                output_done = function ()
                    local state = formattedString

                    if playing and not old_playing then
                        show_player = true
                        state = " Started Playing"
                    end

                    if not playing and not_playing < 20 then
                        not_playing = not_playing + 1
                    end

                    old_playing = playing or not_playing < 3

                    if not playing and not_playing < 3 then
                        state = " Stopped"
                    end

                    callback({
                        progress = progress,
                        state = state,
                        playing = playing or not_playing < 3
                    })
                end
            })
        end
    }
    local lib = helpers.setasyncall(libFunction)

    local data = progressbar(s, color, h, nil, function (progress)
        awful.util.spawn("playerctl position " .. math.floor(progress*max_time), false)
    end)

    vicious.cache(vicious.widgets.volume)
    vicious.register(data.bar, lib,
        function (widget, args)
            data.text:set_text(args.state)
            data.set_hidden(not args.playing)
            -- local gb = math.floor((args[2] / 1000 * 10) + 0.5) / 10
            -- bar:set_value(0.3)
            --
            return args.progress
        end,
        4
    )

    return data.widget
end
