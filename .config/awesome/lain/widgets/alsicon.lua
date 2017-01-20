
--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Luke Bonham
      * (c) 2010, Adrian C. <anrxc@sysphere.org>

--]]

local helpers      = require("lain.helpers")
local read_pipe    = require("lain.helpers").read_pipe

local wibox        = require("wibox")

local string       = { match  = string.match,
                       format = string.format }

local setmetatable = setmetatable

-- ALSA volume
-- lain.widgets.alsicon
local alsicon = helpers.make_widget_textbox()

local function worker(args)
    local args     = args or {}
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    alsicon.cmd           = args.cmd or "amixer"
    alsicon.channel       = args.channel or "Master"
    alsicon.togglechannel = args.togglechannel
    alsicon.last_level    = "0"
    alsicon.last_status   = ""

    function alsicon.update()
        mixer = read_pipe(string.format("%s get %s", alsicon.cmd, alsicon.channel))
        l, s  = string.match(mixer, "([%d]+)%%.*%[([%l]*)")

        -- HDMIs can have a channel different from Master for toggling mute
        if alsicon.togglechannel then
            s = string.match(read_pipe(string.format("%s get %s", alsicon.cmd, alsicon.togglechannel)), "%[(%a+)%]")
        end

        if alsicon.last_level ~= l or alsicon.last_status ~= s then
            volume_now = { level = l, status = s }
            alsicon.last_level  = l
            alsicon.last_status = s

            widget = alsicon.widget
            settings()
        end
    end

    timer_id = string.format("alsicon-%s-%s", alsicon.cmd, alsicon.channel)
    helpers.newtimer(timer_id, timeout, alsicon.update)

    return alsicon
end

return setmetatable(alsicon, { __call = function(_, ...) return worker(...) end })
