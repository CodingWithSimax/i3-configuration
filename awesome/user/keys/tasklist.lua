
local clientkeys = {}

local gears = require('gears')
local awful = require("awful")

local function tasklist_move(change)
    local c = client.focus

    if not c then return end

    local clients = client.get()

    table.sort(clients, function (c1, c2)
        return c1.first_tag.index < c2.first_tag.index
    end)

    local filtered_clients = {}
    for index = 1, #clients do
        local c2 = clients[index]
        if c2.screen.index == c.screen.index then
            table.insert(filtered_clients, c2)
        end
    end
    clients = filtered_clients

    local found_index = 0
    for index = 1, #clients do
        local c2 = clients[index]
        if c2.window == c.window then
            found_index = index
        end
    end

    local dist_index = found_index + change
    local dist_client = clients[dist_index]

    if dist_client == nil then return end

    dist_client:jump_to(false)
    -- awful.util.spawn("notify-send " .. found_index, false)
end

function clientkeys.update_keys(globalkeys, modkey)
	return gears.table.join(globalkeys,
        awful.key(
            {modkey, "Control"}, "d",
            function ()
                tasklist_move(1)
            end,
            {description="client movement", group="awesome"}
        ),
        awful.key(
            {modkey, "Control"}, "a",
            function ()
                tasklist_move(-1)
            end,
            {description="client movement", group="awesome"}
        )
    )
end

return clientkeys
