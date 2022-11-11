local awful = require('awful')

return function ()
    -- get primary and secondary screen
    local primary
    local secondary = nil
    local index = 0
    for s in screen do
        if index == 2 then
            primary = s
        else
            secondary = s
        end
        index = index + 1
    end
    if secondary == nil then
        secondary = primary
    end

    local function move_and_focus(c, tag)
        c:tags({tag})
        tag:view_only()
        awful.spawn.with_shell("notify-send toggle")
    end

    client.connect_signal("property::class", function (c)
        if c.class == "Spotify" then
            move_and_focus(c, secondary.tags[#secondary.tags])
            return
        end

        if c.class == "discord" then
            move_and_focus(c, secondary.tags[#secondary.tags - 1])
            return
        end
    end)
end
