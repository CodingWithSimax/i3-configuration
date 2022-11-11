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

    local not_playing = 10


    local libFunction = {
        async = function (format, warg, callback)
            local formattedString = ""

            local output1 = ' {{ title }} - {{ artist }}'

            local output2 = '{{ position }}'
            local output3 = '{{ status }}'
            local output4 = '{{ mpris:length }}'

            local count = 0
            local progress = 0
            local current_time = 0
            local playing = false


            spawn.with_line_callback('playerctl metadata --format "' .. output1 .. "\n" .. output2 .. "\n" .. output3 .. "\n" .. output4 .. '"', {
                stdout = function (line)
                    count = count + 1
                    if count == 1 then
                        formattedString = line
                    elseif count == 2 then
                        local result = tonumber(line)
                        if result ~= nil then
                            current_time = math.floor(result / 1000 / 1000)
                        end
                    elseif count == 3 and line == "Playing" then
                        playing = true
                        not_playing = 0
                    elseif count == 4 then
                        if line == "" then
                            max_time = -1
                            return
                        end

                        local result = tonumber(line)
                        if result ~= nil then
                            max_time = math.floor(result / 1000 / 1000)
                        end
                    end
                end,
                output_done = function ()
                    local has_length = max_time ~= -1

                    local state = formattedString

                    if not has_length then
                        progress = 100
                        state = state .. "   "
                    else
                        progress = current_time / max_time * 100
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
