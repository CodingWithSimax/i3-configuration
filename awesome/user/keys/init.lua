local keys = {}

local gears = require('gears')
local awful = require("awful")

function keys.update_keys(globalkeys, modkey)
	globalkeys = require('user.keys.rofi').update_keys(globalkeys, modkey)
    globalkeys = require('user.keys.client').update_keys(globalkeys, modkey)
    globalkeys = require('user.keys.media').update_keys(globalkeys, modkey)
    globalkeys = require('user.keys.tasklist').update_keys(globalkeys, modkey)
    globalkeys = require('user.keys.neovide').update_keys(globalkeys, modkey)
    globalkeys = require('user.keys.tag').update_keys(globalkeys, modkey)
    globalkeys = require('user.keys.size').update_keys(globalkeys, modkey)

    return globalkeys
end

return keys
