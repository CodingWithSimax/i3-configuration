local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local menubar = require("menubar")
local palette = require("themes.dracula.palette")
local widget = require("user.wibar.widget")

return function (s, height)
    return widget ({
        awful.widget.tasklist {
            screen   = s,
            source = function (s, args)
                local clients = client.get()
                table.sort(clients, function (c1, c2)
                    return c1.first_tag.index < c2.first_tag.index
                end)
                return clients
            end,
            filter   = awful.widget.tasklist.filter.alltags,
            -- buttons  = tasklist_buttons,
            style    = {
            },
            layout   = {
                spacing = 3,
                layout  = wibox.layout.flex.horizontal
            },
            -- Notice that there is *NO* wibox.wibox prefix, it is a template,
            -- not a widget instance.
            widget_template = {
                {
                    {
                        -- {
                        --     {
                        --         id     = 'icon_role_extended',
                        --         widget = wibox.widget.imagebox
                        --     },
                        --     top = 6,
                        --     bottom = 6,
                        --     right = 6,
                        --     widget  = wibox.container.margin,
                        -- },
                        {
                            {
                                id = "client_name",
                                widget = wibox.widget.textbox,
                                text = "undefined"
                            },
                            fg = palette.orange,
                            widget = wibox.container.background
                        },
                        {
                            {
                                id = "client_tag",
                                widget = wibox.widget.textbox,
                                text = "0"
                            },
                            left = 10,
                            widget = wibox.container.margin
                        },
                        layout = wibox.layout.fixed.horizontal,
                    },
                    left  = 10,
                    right = 10,
                    widget = wibox.container.margin
                },
                id     = 'background_role',
                widget = wibox.container.background,
                create_callback = function(self, c, index, objects) --luacheck: no unused args
                    self:buttons(gears.table.join(
                        awful.button({}, 1, function ()
                            c:jump_to(false)
                        end)
                    ))

                    local client_tag_element = self:get_children_by_id("client_tag")[1]
                    client_tag_element.text = "" .. c.first_tag.name

                    c:connect_signal("tagged", function ()
                        client_tag_element.text = "" .. c.first_tag.name
                    end)

                    local client_name_element = self:get_children_by_id("client_name")[1]

                    local function apply_theme()
                        local s = ""
                        if string.len(c.class) >= 7 then
                            s = string.sub(c.class, 1, 5) .. ".."
                        else
                            s = c.class
                        end
                        client_name_element.text = s
                    end

                    if c.class then
                        apply_theme()
                    end
                    c:connect_signal("property::class", function ()
                        apply_theme()
                    end)

                    -- local function update_icon()
                    --     -- awful.spawn.with_shell("notify-send '" .. menubar.utils.lookup_icon(string.lower(c.class)) .. "'")
                    --     c.theme_icon = c.theme_icon or menubar.utils.lookup_icon(string.lower(c.class))
                    --     if c.theme_icon then
                    --         self:get_children_by_id('icon_role_extended')[1].image = c.theme_icon
                    --     end
                    -- end

                end,
            }
        },

        widget = wibox.container.margin,
        -- left = -1,
        -- right = -1
    }, palette.foreground, height, false)
end
