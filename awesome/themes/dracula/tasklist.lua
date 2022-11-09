local beautiful = require("beautiful")
local palette = require("themes.dracula.palette")

return function (cf)
    cf.tasklist_bg_normal = palette.current_line
    cf.tasklist_bg_focus = palette.comment
    return cf
end
