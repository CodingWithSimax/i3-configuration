local awful = require("awful")

return function (screen)
    local normal_layout = awful.layout.layouts[1]
    local float_layout = awful.layout.suit.floating

    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8"}, screen, normal_layout)

    awful.tag.add("9", {
        layout = float_layout,
        screen = screen
    })

end
