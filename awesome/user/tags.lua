local awful = require("awful")

return function (screen)
    local normal_layout = awful.layout.layouts[1]
    local float_layout = awful.layout.suit.floating

    for index = 1, 8 do
        awful.tag.add("" .. index, {
            layout = normal_layout,
            screen = screen
        })
    end

    awful.tag.add("9", {
        layout = float_layout,
        screen = screen
    })

end
