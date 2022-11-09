local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local menubar = require("menubar")

return function (s)
    return wibox.widget {
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
                shape_border_width = 0,
                shape  = function (cr, w, h)
                    local margin = 5
                    gears.shape.transform(gears.shape.rounded_rect) : translate(margin/2, margin/2) (cr, w-margin, h-margin, 5)
                end
            },
            layout   = {
                spacing = 10,
                spacing_widget = {
                    {
                        forced_width = 5,
                        shape        = gears.shape.circle,
                        widget       = wibox.widget.separator
                    },
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.container.place,
                },
                layout  = wibox.layout.flex.horizontal
            },
            -- Notice that there is *NO* wibox.wibox prefix, it is a template,
            -- not a widget instance.
            widget_template = {
                {
                    {
                        {
                            {
                                id     = 'icon_role_extended',
                                widget = wibox.widget.imagebox
                            },
                            top = 6,
                            bottom = 6,
                            right = 6,
                            widget  = wibox.container.margin,
                        },
                        {
                            id = "client_tag",
                            widget = wibox.widget.textbox,
                            text = "0"
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

                    if not c.class then return end
                    c.theme_icon = c.theme_icon or menubar.utils.lookup_icon(string.lower(c.class)) or c.icon
                    self:get_children_by_id('icon_role_extended')[1].image = c.theme_icon
                end,
            }
        },

        widget = wibox.container.margin,
        left = 10,
    }
end
