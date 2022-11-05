local beautiful = require("beautiful")
local palette = require("themes.dracula.palette")

return function (cf)
    cf.taglist_bg_focus = palette.purple
    cf.taglist_bg_urgent = palette.background
    cf.taglist_bg_empty = palette.background

    cf.taglist_fg_focus = palette.purple
    cf.taglist_fg_occupied = palette.foreground
    cf.taglist_fg_empty = palette.foreground
    cf.taglist_fg_urgent = palette.red
    -- cf.taglist_fg_volatile = palette.foreground

    return cf
end
