-- {{{ Required libraries
local gears             = require("gears")
local awful             = require("awful")
      awful.rules       = require("awful.rules")
local wibox             = require("wibox")
local beautiful         = require("beautiful")
local naughty           = require("naughty")
local drop              = require("scratchdrop")
local lain              = require("lain")
local menubar           = require("menubar")
local scratch           = require("scratchdrop")
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

awful.util.spawn_with_shell("xcompmgr &")
run_once("pasystray")
run_once("unclutter -idle 1")
--run_once("chromium")
run_once("wicd")
run_once("xrdb -merge /home/$USER/.Xresources")
run_once("xmodmap /home/$USER/.Xmodmap")
awful.util.spawn_with_shell("xrdb -merge /home/$USER/.Xresources")
awful.util.spawn_with_shell("xmodmap /home/$USER/.Xmodmap")
run_once("dropboxd")
-- }}}


-- {{{ Variable definitions
-- localization
os.setlocale(os.getenv("LANG"))

-- beautiful init
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/multicolor/theme.lua")





-- common
modkey     = "Mod4"
altkey     = "Mod3"
yarminal   = "urxvt"
terminal  = "gnome-terminal"
editor     = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
browser    = "chromium"
browser2   = "firefox"
browser3   = "dwb"
gui_editor = "gvim"
graphics   = "gimp"
mail       = "thunderbird"



local layouts = {
    --awful.layout.suit.floating,
    --rawful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
   -- awful.layout.suit.fair,
   -- awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
}
-- }}}


-- {{{ Tags
tags = {
   names = { "1", "2", "3", "4", "5", "6", "7", "8", "9"},
   layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] }
}
for s = 1, screen.count() do
-- Each screen has its own tag table.
   tags[s] = awful.tag(tags.names, s, tags.layout)
      
      
      --awful.tag.setproperty( tags[s][7], "ncol", 3)
      --awful.tag.setnmaster(2, tag[s][5])
      --awful.tag.setproperty(tags[s][6], "nmaster", 2)       
      --awful.tag.seticon(beautifu.www_icon, tag[s][7])
      --awful.tag.setproperty(tags[s][8], "icon", beautiful.media_icon)
      --awful.tag.setmwfact( 0.00, tags[s][7])

      --Tag1
      --awful.tag.setmwfact( 0.60, tags[s][1])
      awful.tag.setnmaster(0, tags[s][1]) 
      
      --Tag2
      --awful.tag.setmwfact( 0.60, tags[s][2])
      awful.tag.setnmaster(0, tags[s][2]) 
      
      --Tag3
      --awful.tag.setmwfact( 0.60, tags[s][3])
      awful.tag.setnmaster(0, tags[s][3]) 
      
      --Tag4
      awful.tag.setnmaster(0, tags[s][4]) 
            
      --Tag5
      awful.tag.setnmaster(0, tags[s][5]) 
            
      --Tag6
      --awful.tag.setmwfact( 0.75, tags[s][6])
      awful.tag.setnmaster(0, tags[s][6]) 
      
      --Tag7
      awful.tag.setnmaster(0, tags[s][7]) 
      
      --Tag8
      awful.tag.setnmaster(0, tags[s][8]) 
      
                  require("awful.autofocus")
      --Tag9
      awful.tag.setnmaster(0, tags[s][9]) 


end





-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- }}}

-- {{{ Freedesktop Menu
mymainmenu = awful.menu.new({ items = require("menugen").build_menu(),
                              theme = { height = 12, width = 130 }})
-- }}}

-- {{{ Wibox
markup      = lain.util.markup

-- Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)

-- Weather
--weathericon = wibox.widget.imagebox(beautiful.widget_weather)
yawn = lain.widgets.yawn(123456, {
    settings = function()
        widget:set_markup(markup("#eca4c4", forecast:lower() .. " @ " .. units .. "°C"))
    end
})

-- / fs
fsicon = wibox.widget.imagebox(beautiful.widget_fs)
fswidget = lain.widgets.fs({
    settings  = function()
        widget:set_markup(markup("#80d9d8", fs_now.used .. "% "))
mytextclock = awful.widget.textclock(markup("#999999", "%d-%a") .. markup("#cccccc", ">") .. markup("#de5e1e", " %H:%M "))
    end
})


-- CPU
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup("#999999", cpu_now.usage .. "% "))
    end
})

-- Coretemp
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup("#999999", coretemp_now .. "°C"))
    end
})

-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
    settings = function()
        if bat_now.perc == "N/A" then
            bat_now.perc = "AC "
        else
            bat_now.perc = bat_now.perc .. "% "
        end
        widget:set_markup(markup("#de5e1e", bat_now.perc))
    end
})

-- ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup("#de5e1e", volume_now.level .. "% "))
    end

})
--[[ --Net
netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
--netdownicon.align = "middle"
netdowninfo = wibox.widget.textbox()
netupicon = wibox.widget.imagebox(beautiful.widget_netup)
--netupicon.align = "middle"
netupinfo = lain.widgets.net({
    settings = function()
        if iface ~= "network off" and
           string.match(yawn.widget._layout.text, "N/A")
        then
            yawn.fetch_weather()
        end

        widget:set_markup(markup("#999999", net_now.sent ))
        netdowninfo:set_markup(markup("#999999", net_now.received ))
    end
})
]]


--Batttery warning (from ArchWiki)
local function trim(s)
  return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

local function bat_notification()
  local f_capacity = assert(io.open("/sys/class/power_supply/BAT1/capacity", "r"))
  local f_status = assert(io.open("/sys/class/power_supply/BAT1/status", "r"))
  local bat_capacity = tonumber(f_capacity:read("*all"))
  local bat_status = trim(f_status:read("*all"))

  if (bat_capacity <= 10 and bat_status == "Discharging") then
    	naughty.notify({ title      = "Battery Warning",
			text       = "Battery low! " .. bat_capacity .."%" .. " left!",
			fg="#ffffff",
			bg="#C91C1C",
			timeout    = 59,
			position   = "top_right"
    			})
  end
end

battimer = timer({timeout = 60})
battimer:connect_signal("timeout", bat_notification)
battimer:start()
-- end here for battery warning



-- MEM
memicon = wibox.widget.imagebox(beautiful.widget_mem)
memwidget = lain.widgets.mem({
    settings = function()
        widget:set_markup(markup("#999999", mem_now.used .. "M"))
    end
})

-- MPD
mpdicon = wibox.widget.imagebox()
mpdwidget = lain.widgets.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
            mpdicon:set_image(beautiful.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(nil)
        end
        widget:set_markup(markup("#e54c62", artist) .. markup("#b2b2b2", title))
    end
})

-- Spacer
spacer = wibox.widget.textbox(" ")
--Another spacer
yapacer = wibox.widget.textbox(">")
yaparacer = wibox.widget.textbox("-")


--Menubar
menubar.utils.terminal = terminal

-- }}}

-- {{{ Layout

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()


    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the upper wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 16 })
    --border_width = 0, height =  20 })

    -- Widgets that are aligned to the upper left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    left_layout:add(mpdicon)
    left_layout:add(mpdwidget)
    left_layout:add(yapacer)

    -- Widgets that are aligned to the upper right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    --right_layout:add(mailicon)
    --right_layout:add(mailwidget)
    --right_layout:add(spacer)
    --right_layout:add(yapacer)
    --right_layout:add(netdowninfo)
    --right_layout:add(netupicon)
    --right_layout:add(yaparacer)
    --right_layout:add(netupinfo)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(yapacer)
    --right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(yaparacer)
    --right_layout:add(yapacer)
   -- right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    --right_layout:add(fsicon)
    --right_layout:add(fswidget)
    --right_layout:add(weathericon)
    --right_layout:add(yawn.widget)
    --right_layout:add(tempicon)
    --right_layout:add(yapacer)
    --right_layout:add(tempwidget)
    right_layout:add(baticon)
     right_layout:add(batwidget)
   -- right_layout:add(clockicon)
    right_layout:add(mytextclock)
   -- right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

    -- Create the bottom wibox
    --mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 20 })
    --mybottomwibox[s].visible = false

    -- Widgets that are aligned to the bottom left
    --bottom_left_layout = wibox.layout.fixed.horizontal()

    -- Widgets that are aligned to the bottom right
    bottom_right_layout = wibox.layout.fixed.horizontal()
    bottom_right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    --bottom_layout = wibox.layout.align.horizontal()
    --bottom_layout:set_left(bottom_left_layout)
    --bottom_layout:set_middle(mytasklist[s])
    --bottom_layout:set_right(bottom_right_layout)
    --mybottomwibox[s]:set_widget(bottom_layout)
end
-- }}}

-- {{{ Mouse Bindings
--[[root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
]]
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

--By direction client focus
  awful.key({ modkey }, "j",
      function()
          awful.client.focus.bydirection("down")
          if client.focus then client.focus:raise() end
      end),
  awful.key({ modkey }, "k",
      function()
          awful.client.focus.bydirection("up")
          if client.focus then client.focus:raise() end
      end),
  awful.key({ modkey }, "h",
      function()
          awful.client.focus.bydirection("left")
          if client.focus then client.focus:raise() end
      end),
  awful.key({ modkey }, "l",
      function()
          awful.client.focus.bydirection("right")
          if client.focus then client.focus:raise() end
      end),

--Focus next/prev client
  awful.key({ modkey }, "n",
      function ()
          awful.client.focus.byidx( 1)
          if client.focus then client.focus:raise() end
      end),

--









    -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
    --awful.key({ altkey }, "p", function() os.execute("screenshot") end),

    -- Tag browsing
    awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey }, "Right",  awful.tag.viewnext       ),
    --awful.key({ altkey }, "h",   awful.tag.viewprev       ),
    --awful.key({ altkey }, "l",  awful.tag.viewnext       ),
    --awful.key({ modkey }, "Escape", awful.tag.history.restore),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),
    --awful.key({ altkey }, "h", function () lain.util.tag_view_nonempty(-1) end),
    --awful.key({ altkey }, "l", function () lain.util.tag_view_nonempty(1) end),

    --Switch screens
    awful.key({ modkey }, "F1",  function () awful.screen.focus(2) end),
    awful.key({ modkey }, "F2",  function () awful.screen.focus(1) end),
    awful.key({ modkey }, "F3",  function () awful.screen.focus(3) end),




    -- Default client focus
    awful.key({ modkey }, "Up",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "Down",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),



   


    -- Show Menu
    awful.key({ modkey }, "v",
        function ()
            mymainmenu:show({ keygrabber = true })
        end),
    --Menubar
	awful.key({ modkey }, "backslash", function() menubar.show() 	end),
	awful.key({ modkey }, "z", function() menubar.show() 	end),
    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
        --mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
    end),

    -- Layout manipulation (swapNfocus)
    awful.key({ altkey,        }, "l", function () awful.client.swap.byidx(  1)    end),
    awful.key({ altkey,        }, "h", function () awful.client.swap.byidx( -1)    end),
           --Change focus (Same client selected after swapping)
		--awful.key({ altkey,        }, "l",  function () awful.client.focus.byidx(  1)    end),
		--awful.key({ altkey,        }, "h", function () awful.client.focus.byidx( -1)    end),

    
    awful.key({ modkey, "Control"}, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control"}, "k", function () awful.screen.focus_relative(-1) end),
    
    
    
    awful.key({ altkey,           }, "Tab", awful.client.urgent.jumpto),
    --awful.key({ modkey,           }, "Tab",
    --    function ()
    --        awful.client.focus.history.previous()
    --        if client.focus then
    --            client.focus:raise()
    --        end
    --    end),



    --Lock Screen
    awful.key({ modkey }, "F12", function () awful.util.spawn("xlock") end),
    
    
   awful.key({ altkey }, "j",      function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ altkey }, "k",      function () awful.tag.incmwfact( - 0.05)     end),
   
   
   awful.key({ altkey,   }, "comma",      function () awful.tag.incnmaster( -1)     end),
   awful.key({ altkey,   }, "period",      function () awful.tag.incnmaster( 1)     end),
    
    
     -- awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    -- awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
        
    
  awful.key({ altkey, "Shift" }, "greater",      function () awful.tag.incncol(1)          end),
  awful.key({ altkey, "Shift" }, "less",      function () awful.tag.incncol( -1)          end),
   
    
    
    awful.key({ modkey,            }, "space",  function () awful.layout.inc(layouts,  1)  end),
    --awful.key({ modkey, "Mod1" }, "space",  function () awful.layout.inc(layouts,  -1)  end),
    --awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
    awful.key({ modkey,  }, "a",      awful.client.restore),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "s", function () awful.util.spawn("gksu") end),
    
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    --awful.key({ modkey, "Shift"   }, "q",      awesome.quit), 	--causes problems with awesome-gnome




    -- Dropdown terminal and more
    -- !!!!!!!!! drop function syntax is scratch.drop(prog,vert="top",horiz="center",width=1,height=0.25,sticky=false)
    -- !!! the default height was modified to 0.50
    -- !!! to do that, edit /usr/share/awesome/lib/scratchpad/drop.lua
    awful.key({ modkey,	          }, "grave",      function () drop(terminal) end), 
    awful.key({ modkey,	          }, "KP_Add",      function () awful.util.spawn(yarminal) end), 
    awful.key({ modkey,	          }, "Tab" ,      function () drop("urxvt -e ranger") end), 
    awful.key({ modkey,	          }, "KP_Subtract" ,      function () drop(browser2) end), 
    awful.key({ modkey,	          }, "KP_Divide" ,      function () drop("gvim") end), 
    awful.key({ modkey,	          }, "KP_Multiply",      function () drop("urxvt -e ranger") end), 

    awful.key({ modkey, "Control" }, "KP_Add",      function () drop("urxvt -e byobu") end), 



  
    -- ALSA volume control
    awful.key({  }, "XF86AudioRaiseVolume",
        function ()
            awful.util.spawn("amixer -q set Master 5%+")
            volumewidget.update()
        end),
  
    awful.key({  }, "XF86AudioLowerVolume",
        function ()
            awful.util.spawn("amixer -q set Master 5%-")
            volumewidget.update()
        end),
  
    awful.key({  }, "XF86AudioMute",
        function ()
            awful.util.spawn("amixer -q set Master playback toggle")
            volumewidget.update()
        end),



    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.util.spawn_with_shell("mpc next || ncmpc next || pms next")
            mpdwidget.update()
        end),

    -- Copy to clipboard
    awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),









    -- User programs
    --awful.key({ altkey }, "Escape", function () run_once("unclutter") end),
    awful.key({ altkey }, "1", function () awful.util.spawn(browser) end),
    awful.key({ altkey }, "2", function () awful.util.spawn(browser2) end),
    awful.key({ altkey }, "3", function () awful.util.spawn(browser3) end),
    awful.key({ altkey }, "4", function () awful.util.spawn("thunar") end),
    awful.key({ altkey }, "5", function () awful.util.spawn("gnome-terminal -e ranger") end),
    awful.key({ altkey }, "6", function () awful.util.spawn("tor-browser-en") end),
    --awful.key({ altkey }, "7", function () awful.util.spawn(yarminal) end),
    awful.key({ altkey }, "8", function () awful.util.spawn("firefox --private-window") end),
    --awful.key({ altkey }, "9", function () awful.util.spawn(terminal) end),
    --awful.key({ altkey}, "0", function () awful.util.spawn() end),








    --[[ Prompt Drop
    awful.key({ modkey }, "x", function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey, "Shift" }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
    ]]

    -- Prompt
    awful.key({ modkey }, "x", function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey, "Shift" }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift" }, "F1",      function(c) awful.client.movetoscreen(c, 2) end ),
    awful.key({ modkey, "Shift" }, "F2",      function(c) awful.client.movetoscreen(c, 1) end ),
    awful.key({ modkey, "Shift" }, "F3",      function(c) awful.client.movetoscreen(c, 3) end ),

    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "Escape",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, 	  }, "g",      awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop           end),
    awful.key({ modkey,           }, "y",      function (c) c.sticky = not c.sticky        end),
    awful.key({ modkey,           }, "u",      function (c) c.floating = not c.floating    end),
    awful.key({ modkey,           }, "u",      function (c) c.below = not c.below          end),
    awful.key({ modkey,           }, "i",      function (c) c.above = not c.above          end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        --awful.key({ modkey, "Control" }, "#" .. i + 9,
        --          function ()
        --              local screen = mouse.screen
        --              local tag = awful.tag.gettags(screen)[i]
        --              if tag then
        --                 awful.tag.viewtoggle(tag)
        --              end
        --          end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}












-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
	                   size_hints_honor = false } },
    { rule = { }, 
        properties = { }, callback = awful.client.setslave },
        
        
    { rule = { class = "URxvt" },
          properties = { opacity = 0.90 } },
    
  { rule = { class = "Gnome-terminal" },
          properties = { opacity = 0.90 } },

    { rule = { class = "MPlayer" },
          properties = { floating = true } },

--    { rule = { class = "Chromium" },
--          properties = { tag = tags[1][1] } },

--    { rule = { class = "Chromium", 
--		name =  "YouTube"},
--          properties = { floating = false,
--			maximized = false } },
           
--    { rule = { class = "Thunderbird" },
--          properties = { tag = tags[1][1] } },

--    { rule = { class = "Chromium"}, 
--          properties = { below = true,
--			maximized_horizontal = true,
--			maximized_vertical = true } },

    { rule = { class = "Gretl_x11" },
          properties = { floating = true } },

    { rule = { name = "Page(s) Unresponsive" },
          properties = { floating = true } },

    { rule = { name = "Firefox Preferences" },
          properties = { floating = true } },

    { rule = { name = "Wicd Network Manager" },
          properties = { floating = true } },

--    { rule = { name = "n - File Manager" },
--          properties = { tag = tags[1][4] } },

--    { rule = { class = "Gnome-terminal" },
--          properties = { tag = tags[1][7] } },
          
--    { rule = { class = "Tor Browser"},
--          properties = { tag = tags[1][6] } },
          
--    { rule = { class = "Firefox" },
--                     border_color = beautiful.border_normal,
--          properties = { tag = tags[1][2] } },

    { rule = { class = "Gvim" },
          properties = { opacity = 0.90 } },

    { rule = { class = "Subl3" },
          properties = { opacity = 0.90 } },

    { rule = { class = "TexMaker" },
          properties = { opacity = 0.90 } },
--    { rule = { class = "Gimp" },
--          properties = { tag = tags[1][8] } },

--    { rule = { class = "libreoffice" },
--          properties = { tag = tags[1][8] } },
        
    --{ rule = { class = "Vlc" },
      --    properties = { tag = tags[1][5] } },
       
    { rule = { class = "Vlc" },
          properties = { floating = true} },
        
--    { rule = { class = "Vinagre" },
--          properties = { tag = tags[1][7] } },
       
    { rule = { class = "Vinagre" },
          properties = { floating = true} },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized_horizontal = true,
                         maximized_vertical = true } },
}
-- }}}

-- {{{ Signals
-- signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup and not c.size_hints.user_position
       and not c.size_hints.program_position then
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
    end

    local titlebars_enabled = false
    --[[if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- the title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c,{size=16}):set_widget(layout)
    end
    ]]
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_color = beautiful.border_normal
        else
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        if #clients > 0 then -- Fine grained borders and floaters control
            for _, c in pairs(clients) do -- Floaters always have borders
                -- No borders with only one humanly visible client
                if layout == "max" then
                    c.border_width = 0
                elseif awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width
                elseif #clients == 1 then
                    clients[1].border_width = 0
                    if layout ~= "max" then
                        awful.client.moveresize(0, 0, 2, 0, clients[1])
                    end
                else
                    c.border_width = beautiful.border_width
                end
            end
        end
      end)
end
-- }}}
