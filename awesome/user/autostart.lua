local awful = require("awful")

local is_restart
do
    local restart_detected
    is_restart = function()
        -- If we already did restart detection: Just return the result
        if restart_detected ~= nil then
            return restart_detected
        end

        -- Register a new boolean
        awesome.register_xproperty("awesome_restart_check", "boolean")
        -- Check if this boolean is already set
        restart_detected = awesome.get_xproperty("awesome_restart_check") ~= nil
        -- Set it to true
        awesome.set_xproperty("awesome_restart_check", true)
        -- Return the result
        return restart_detected
    end
end

return function ()
    -- autostart
    awful.spawn.with_shell(os.getenv('HOME') .. '/.config/awesome/resolution.sh')

    if not is_restart() then
        awful.spawn.with_shell("picom")
        awful.spawn.with_shell("nm-applet")
        awful.spawn.with_shell("jetbrains-toolbox --minimize")
    end
end
