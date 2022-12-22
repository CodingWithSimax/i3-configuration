local awful = require('awful')
local gears = require('gears')

local function update(client)
    awful.screen.connect_for_each_screen(function(s)
        local clientCount = #s.tiled_clients

        if clientCount == 0 then return end

        if clientCount == 1 then
            if not s.tiled_clients[1].is_rounded then return end
            s.tiled_clients[1].shape = function (cr, w, h)
                gears.shape.rounded_rect(cr, w, h, 0)
            end
            s.tiled_clients[1].is_rounded = false
        else
            for i=1,clientCount do
                if not s.tiled_clients[i].is_rounded then
                    s.tiled_clients[i].shape = function (cr, w, h)
                        gears.shape.rounded_rect(cr, w, h, 8)
                    end
                    s.tiled_clients[i].is_rounded = true
                end
            end
        end
    end)
end

return function (client)
    -- client.connect_signal("property::screen", function (c) update(client) end)
    -- client.connect_signal("manage", function (c)
    --     update(client)
    -- end)
    -- client.connect_signal("tagged", function (c) update(client) end)
    -- client.connect_signal("unmanage", function (c)
    --     update(client)
    -- end)
end
