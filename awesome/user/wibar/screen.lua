local wibox = require("wibox")

return function (s)
    local m = 5

    local text = wibox.widget {

        widget = wibox.widget.textbox,
        text = "hallo"
    }

    return wibox.widget {
        text,
        widget = wibox.container.margin,
        left = m,
        right = m
    }
end
