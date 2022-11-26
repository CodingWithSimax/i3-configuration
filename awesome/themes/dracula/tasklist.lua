local beautiful = require("beautiful")
local palette = require("themes.dracula.palette")

return function (cf)
    cf.tasklist_bg_normal = palette.background
    cf.tasklist_bg_focus = palette.current_line
    return cf
end
