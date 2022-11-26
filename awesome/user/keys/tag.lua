local M = {}

local gears = require('gears')
local awful = require("awful")

return {
    update_keys = function (globalkeys, mod)
        return gears.table.join(globalkeys,
            awful.key(
                {mod}, "r",
                function ()
                    local current_tag = awful.screen.focused().selected_tag
                    local layouts = awful.layout.layouts

                    local next_layout = nil
                    for i=1, #layouts do
                        if current_tag.layout == layouts[i] then
                            if i == #layouts then
                                next_layout = layouts[1]
                            else
                                next_layout = layouts[i+1]
                            end
                        end
                    end
                    if next_layout ~= nil then
                        current_tag.layout = next_layout
                    end
                end,
                {description="show help", group="awesome"}
            )
        )
    end
}

