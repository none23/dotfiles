-- Requirements {{{
------------------------------------------------------------------------------

local gears     = require("gears")        -- for wallpaper
local awful     = require("awful")
  awful.rules   = require("awful.rules")
                  require("awful.autofocus")
local wibox     = require("wibox")
local naughty   = require("naughty")      -- errors
local drop      = require("scratchdrop")  -- drop-down clients
local lain      = require("lain")         -- additional widgets
local menubar   = require("menubar")      -- dmenu
local nlay      = require("nlay")         -- my layout
local beautiful = require("beautiful")    -- theme
      beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")


-- }}}
-- Aliases {{{
------------------------------------------------------------------------------

Super = "Mod4"
Hyper = "Mod3"
Shift = "Shift"
Cntrl = "Control"

-- }}}
-- Notifications {{{
-- startup errors {{{
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical
                   , title = "Oops, you're out of luck, buddy!"
                   , text = awesome.startup_errors
                   })
end
-- }}}
-- runtime errors {{{
do
    local in_error = false
    awesome.connect_signal( "debug::error"
                          , function (err)
                                if in_error then return end
                                in_error = true
                                naughty.notify({ preset = naughty.config.presets.critical
                                               , title = "Looks like you fucked it up!"
                                               , text = err
                                               })
                                in_error = false
                            end
                          )
end

-- }}}
-- batttery warnings {{{
local function trim(s)
    return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

local function bat_notification()
    local f_capacity = assert(io.open("/sys/class/power_supply/BAT1/capacity", "r"))
    local f_status = assert(io.open("/sys/class/power_supply/BAT1/status", "r"))
    local bat_capacity = tonumber(f_capacity:read("*all"))
    local bat_status = trim(f_status:read("*all"))

    if (bat_capacity <= 10 and bat_status == "Discharging") then
      naughty.notify({ title = "I'm dying!"
                     , text =  bat_status .."% left! Click to suspend"
                     , fg = beautiful.bg
                     , bg = beautiful.danger
                     , timeout = 60
                     , position = "top_right"
                     , run = function(_) awful.util.spawn_with_shell("systemctl suspend") end
                     })
    elseif (bat_capacity <= 40 and bat_status == "Discharging") then
        naughty.notify({ title = "Hey, the battery is halfway dead"
                       , text = bat_capacity .."% left! But you know how crappy the battery is..."
                       , fg = beautiful.bg
                       , bg = beautiful.danger
                       , timeout= 5
                       , position   = "top_right"
                       })
    end
end

battimer = timer({timeout = 60})
battimer:connect_signal("timeout", bat_notification)
battimer:start()

-- }}}
-- boot time {{{
local function startup_time_notification ()
  os.execute("/usr/local/bin/startup-time > /tmp/startup-time")
  local f_boot_time_info = assert(io.open("/tmp/startup-time")):read("*all")
  naughty.notify({ title = "Welcome back"
                 , text = f_boot_time_info
                 , preset = naughty.config.presets.low
                 , timeout = 5
                 , position = "top_right"
                 })
end
-- }}}
-- }}}
-- Autostart {{{
------------------------------------------------------------------------------

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
      findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end


run_once("chromium")
run_once("konsole -e zsh")
startup_time_notification()

-- }}}
-- Layouts & Tags Table {{{
------------------------------------------------------------------------------
-- Create {{{

local layouts = { nlay
                , awful.layout.suit.tile
                , awful.layout.suit.tile.bottom
                , awful.layout.suit.tile.top
                , awful.layout.suit.fair,fair
                }

tags = { name = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
       , layout = { layouts[4], layouts[2], layouts[2], layouts[1], layouts[1]
                  , layouts[2], layouts[2], layouts[2], layouts[3]
                  }
       }

for s = 1, screen.count() do
    tags[s] = awful.tag(tags.name, s, tags.layout)
end

-- }}}
-- Config {{{

-- primary screen
-- tag 1
awful.tag.setnmaster(1, tags[1][1])
awful.tag.setncol(1, tags[1][1])
awful.tag.setmwfact(0.85, tags[1][1])

-- tags 2-8
for t = 2, 8 do
    awful.tag.setnmaster(1, tags[1][t])
    awful.tag.setncol(1, tags[1][t])
    awful.tag.setmwfact(0.625, tags[1][t])
end

-- tag 9
awful.tag.setnmaster(3, tags[1][9])
awful.tag.setncol(1, tags[1][9])
awful.tag.setmwfact(0.5, tags[1][9])

-- secondary screens
for s = 2, screen.count() do
    for t = 1, 9 do
        awful.tag.setnmaster(1, tags[s][t])
        awful.tag.setncol(1, tags[s][t])
        awful.tag.setmwfact(0.625, tags[s][t])
    end
end

-- }}}
-- }}}
-- Wallpaper {{{
------------------------------------------------------------------------------

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- }}}
-- Wibox Widgets {{{
------------------------------------------------------------------------------
local function wrap_widget (target_widget, target_bg, target_fg, margin_left, margin_right )
  local wrapped_inner = wibox.layout.margin()
    wrapped_inner:set_top(1)
    wrapped_inner:set_right(margin_right)
    wrapped_inner:set_bottom(1)
    wrapped_inner:set_left(margin_left)
    wrapped_inner:set_widget(target_widget)

  local wrapped_widget = wibox.widget.background()
    wrapped_widget:set_widget(wrapped_inner)
    wrapped_widget:set_bg(target_bg)
    wrapped_widget:set_fg(target_fg)

  return wrapped_widget
end

local function wrap_icon (image)
  local wrapped_icon = wibox.layout.margin()
    wrapped_icon:set_widget(wibox.widget.imagebox(image))
    wrapped_icon:set_margins(-1)
  return wrapped_icon
end

-- memory {{{
  memwidget_wrap = wrap_widget ( lain.widgets.mem({ settings = function()
                                                                 if mem_now.used < 1000 then
                                                                   widget:set_text(' ' .. mem_now.used)
                                                                 else
                                                                   widget:set_text(mem_now.used)
                                                                 end
                                                               end
                                                  })
                               , beautiful.midgray_0
                               , beautiful.fg
                               , 3
                               , 0
                               ) --}}}
-- cpu {{{

  cpuwidget_wrap = wrap_widget ( lain.widgets.cpu({ settings = function() widget:set_text(":" .. cpu_now.usage) end })
                               , beautiful.midgray_0
                               , beautiful.primary
                               , 0
                               , 4
                               ) -- }}}
-- alsa volume {{{
  volumewidget_wrap = wrap_widget ( lain.widgets.alsa({ settings = function()
                                                                    if volume_now.status == "off" then
                                                                      volume_now.level = volume_now.level .. "M"
                                                                    end
                                                                    widget:set_text(volume_now.level .. "%")
                                                                  end
                                                     })
                                 , (beautiful.midgray_1)
                                 , (beautiful.fg)
                                 , 2
                                 , 4
                                 ) -- }}}
-- battery {{{
batwidget_wrap = wrap_widget ( lain.widgets.bat({ settings = function()
                                                               if bat_now.perc == "N/A" then
                                                                   bat_now.perc = bat_now.perc .. "C"
                                                               else
                                                                   bat_now.perc = bat_now.perc .. "%"
                                                               end
                                                               widget:set_text(bat_now.perc)
                                                             end
                                                })
                             , beautiful.midgray_0
                             , beautiful.primary
                             , 2
                             , 4
                             ) -- }}}
-- date {{{
  datewidget_wrap = wrap_widget ( awful.widget.textclock( '<span>' ..  tostring("%d-%a") ..  '</span>', 100)
                                , beautiful.midgray_1
                                , beautiful.fg
                                , 3
                                , 4
                                ) -- }}}
-- clock {{{
  clockwidget_wrap = wrap_widget ( awful.widget.textclock( '<span>' ..  tostring("%H:%M") ..  '</span>', 10)
                                 , beautiful.primary
                                 , beautiful.black
                                 , 3
                                 , 4
                                 ) -- }}}
-- icons {{{
--[[ arrow separators naming: {{{
---         ╭―――― points left           │        ╭―――― points right
---         ▼                           │        ▼
---  arrow_1L2                          │ arrow_0R1
---        ▲ ▲                          │       ▲ ▲
---        │ ╰――― right half is color'2'│       │ ╰――― right half is color '1'
---        ╰――――― left half is '1'      │       ╰――――― left half is color '0'
--}}} ]]
arrow_2L3 = wrap_icon(beautiful.arrow_2L3)
arrow_2L1 = wrap_icon(beautiful.arrow_2L1)
arrow_1L2 = wrap_icon(beautiful.arrow_1L2)
arrow_0L1 = wrap_icon(beautiful.arrow_0L1)
arrow_1R0 = wrap_icon(beautiful.arrow_1R0)
volicon   = wrap_icon(beautiful.widget_vol)
baticon   = wrap_icon(beautiful.widget_bat)
loadicon  = wrap_icon(beautiful.widget_load)

-- }}}

-- }}}
-- Wibox {{{
mywibox = {}
mytaglist = {}
mypromptbox = {}
mytasklist = {}

-- buttons {{{

mytaglist.buttons = awful.util.table.join( awful.button({ },       1, awful.tag.viewonly)
                                         , awful.button({ },       3, awful.tag.viewtoggle)
                                         , awful.button({ Super }, 1, awful.client.movetotag)
                                         , awful.button({ Super }, 3, awful.client.toggletag)
                                         )

mytasklist.buttons = awful.util.table.join( awful.button( { }, 1 , function (c)
                                                                     if c == client.focus then
                                                                       c.minimized = true
                                                                     else
                                                                       c.minimized = false
                                                                       if not c:isvisible() then
                                                                         awful.tag.viewonly(c:tags()[1])
                                                                       end
                                                                       client.focus = c
                                                                       c:raise()
                                                                     end
                                                                   end
                                                        )
                                          )

-- }}}

for s = 1, screen.count() do
    mytaglist[s] = awful.widget.taglist( s
                                       , awful.widget.taglist.filter.all
                                       , mytaglist.buttons
                                       )

    local taglist_margin = wibox.layout.margin()
      taglist_margin:set_widget(mytaglist[s])
      taglist_margin:set_margins(0)

    local taglist_wrap = wibox.widget.background()
      taglist_wrap:set_widget(taglist_margin)
      taglist_wrap:set_bg(beautiful.midgray_0)

    mypromptbox[s] = awful.widget.prompt()

    mytasklist[s] = awful.widget.tasklist( s
                                         , awful.widget.tasklist.filter.currenttags
                                         , mytasklist.buttons
                                         )

    mywibox[s] = awful.wibox({ position = "top"
                             , screen = s
                             , height = 16
                             })
    -- Left {{{
    local promptbox_margin = wibox.layout.margin()
      promptbox_margin:set_widget(mypromptbox[s])
      promptbox_margin:set_margins(0)

    local promptbox_wrap = wibox.widget.background()
      promptbox_wrap:set_widget(promptbox_margin)
      promptbox_wrap:set_bg(beautiful.midgray_0)

    local left_layout = wibox.layout.fixed.horizontal()
      left_layout:add(taglist_wrap)
      left_layout:add(promptbox_wrap)
      left_layout:add(arrow_1R0)

    -- }}}
    -- Right {{{
    local right_layout = wibox.layout.fixed.horizontal()

    -- systray
    right_layout:add(wibox.widget.systray())

    -- mem / cpu state
    right_layout:add(arrow_0L1)
    right_layout:add(loadicon)
    right_layout:add(memwidget_wrap)
    right_layout:add(cpuwidget_wrap)

    -- volume
    right_layout:add(arrow_1L2)
    right_layout:add(volicon)
    right_layout:add(volumewidget_wrap)

    -- battery
    right_layout:add(arrow_2L1)
    right_layout:add(baticon)
    right_layout:add(batwidget_wrap)

    -- date
    right_layout:add(arrow_1L2)
    right_layout:add(datewidget_wrap)

    -- time
    right_layout:add(arrow_2L3)
    right_layout:add(clockwidget_wrap)

    -- }}}
    -- Bring it all together {{{

    local layout = wibox.layout.align.horizontal()
      local layout_margin = wibox.layout.margin()
        layout_margin:set_widget(layout)
        layout_margin:set_margins(0)

      local left_layout_margin = wibox.layout.margin()
        left_layout_margin:set_widget(left_layout)
        left_layout_margin:set_margins(0)

      local right_layout_margin = wibox.layout.margin()
        right_layout_margin:set_widget(right_layout)
        right_layout_margin:set_margins(0)

      layout:set_left( left_layout_margin )
      layout:set_middle( mytasklist[s] )
      layout:set_right( right_layout_margin )

    mywibox[s]:set_widget(layout)

    -- }}}
end
-- }}}
-- Keybindings {{{
-- Global keybindings {{{
globalkeys = awful.util.table.join(
  awful.key( { Super        }, "j",        function () awful.client.focus.global_bydirection("down") if client.focus then client.focus:raise() end  end )
, awful.key( { Super        }, "k",        function () awful.client.focus.global_bydirection("up") if client.focus then client.focus:raise() end    end )
, awful.key( { Super        }, "h",        function () awful.client.focus.global_bydirection("left") if client.focus then client.focus:raise() end  end )
, awful.key( { Super        }, "l",        function () awful.client.focus.global_bydirection("right") if client.focus then client.focus:raise() end end )
, awful.key( { Super        }, "w",        function () awful.client.focus.byidx( 1) if client.focus then client.focus:raise() end                   end )
, awful.key( { Super        }, "b",        function () awful.client.focus.history.previous() if client.focus then client.focus:raise() end          end )
, awful.key( { Super, Shift }, "j",        function () awful.client.swap.global_bydirection("down")                                                 end )
, awful.key( { Super, Shift }, "k",        function () awful.client.swap.global_bydirection("up")                                                   end )
, awful.key( { Super, Shift }, "h",        function () awful.client.swap.global_bydirection("left")                                                 end )
, awful.key( { Super, Shift }, "l",        function () awful.client.swap.global_bydirection("right")                                                end )
, awful.key( { Super        }, "a",        function () awful.client.restore()                                                                       end )
, awful.key( { Super        }, "space",    function () awful.layout.inc(layouts,  1)                                                                end )
, awful.key( { Super        }, "period",   function () awful.tag.incncol(1)                                                                         end )
, awful.key( { Super        }, "comma",    function () awful.tag.incncol(-1)                                                                        end )
, awful.key( { Super        }, "Down",     function () awful.tag.incnmaster(-1)                                                                     end )
, awful.key( { Super        }, "Up",       function () awful.tag.incnmaster(1)                                                                      end )
, awful.key( { Super        }, "Right",    function () awful.tag.incmwfact(0.01)                                                                    end )
, awful.key( { Super        }, "Left",     function () awful.tag.incmwfact(-0.01)                                                                   end )
, awful.key( { Super, Shift }, "Right",    function () awful.tag.incmwfact(0.05)                                                                    end )
, awful.key( { Super, Shift }, "Left",     function () awful.tag.incmwfact(-0.05)                                                                   end )
, awful.key( { Super        }, "Next",     function () lain.util.tag_view_nonempty(1)                                                               end )
, awful.key( { Super        }, "Prior",    function () lain.util.tag_view_nonempty(-1)                                                              end )
, awful.key( { Super        }, "F1",       function () awful.screen.focus(1)                                                                        end )
, awful.key( { Super        }, "F2",       function () awful.screen.focus(2)                                                                        end )
, awful.key( { Super        }, "F3",       function () awful.screen.focus(3)                                                                        end )
, awful.key( { Super        }, "z",        function () menubar.show()                                                                               end )
, awful.key( { Super        }, "x",        function () mypromptbox[mouse.screen]:run()                                                              end )
, awful.key( { Super        }, "Return",   function () awful.util.spawn("konsole -e zsh")                                                           end )
, awful.key( { Super        }, "KP_Enter", function () awful.util.spawn_with_shell("urxvt")                                                         end )
, awful.key( { Hyper        }, "grave",    function () awful.util.spawn("konsole -e nvim")                                                          end )
, awful.key( { Hyper        }, "1",        function () awful.util.spawn("chromium")                                                                 end )
, awful.key( { Hyper, Cntrl }, "1",        function () awful.util.spawn("tor-browser-en")                                                           end )
, awful.key( { Hyper        }, "2",        function () awful.util.spawn("firefox")                                                                  end )
, awful.key( { Hyper, Cntrl }, "2",        function () awful.util.spawn("chromium --kiosk")                                                         end )
, awful.key( { Hyper        }, "3",        function () awful.util.spawn("atom")                                                                     end )
, awful.key( { Hyper        }, "4",        function () awful.util.spawn("inkscape")                                                                 end )
, awful.key( { Hyper        }, "5",        function () awful.util.spawn("gimp")                                                                     end )
, awful.key( { Hyper        }, "6",        function () awful.util.spawn("blender")                                                                  end )
, awful.key( { Hyper        }, "7",        function () awful.util.spawn("arandr")                                                                   end )
, awful.key( { Hyper        }, "8",        function () awful.util.spawn("transset-df 1")                                                            end )
, awful.key( { Hyper, Cntrl }, "8",        function () awful.util.spawn("transset-df .8")                                                           end )
, awful.key( { Hyper        }, "9",        function () awful.util.spawn("transset-df .65")                                                          end )
, awful.key( { Hyper, Cntrl }, "9",        function () awful.util.spawn("transset-df .4")                                                           end )
, awful.key( { Super        }, "grave",    function () drop("konsole -e zsh")                                                                       end )
, awful.key( { Super        }, "Tab" ,     function () drop("konsole -e ranger")                                                                    end )
, awful.key( { Super        }, "F10",      function () awful.util.spawn("touchpad_ctrl")                                                            end )
, awful.key( { Super        }, "F12",      function () awful.util.spawn("xscreensaver-command -lock")                                               end )
, awful.key( { Super        }, "c",        function () os.execute("xsel -p -o | xsel -i -b")                                                        end )
, awful.key( { Super, Cntrl }, "r",        awesome.restart                                                                                              )
, awful.key( { Super, Cntrl }, "q",        awesome.quit                                                                                                 )
, awful.key( { }, "XF86AudioRaiseVolume",  function () awful.util.spawn("amixer -q set Master 5%+"); volumewidget.update()                          end )
, awful.key( { }, "XF86AudioLowerVolume",  function () awful.util.spawn("amixer -q set Master 5%-"); volumewidget.update()                          end )
, awful.key( { }, "XF86AudioMute",         function () awful.util.spawn("amixer -q set Master playback toggle"); volumewidget.update()              end )
)
-- }}}
-- Client keybindings {{{
clientkeys = awful.util.table.join(
  awful.key( { Super, Shift }, "F1",        function (c) awful.client.movetoscreen(c, 1)                                                            end )
, awful.key( { Super, Shift }, "F2",        function (c) awful.client.movetoscreen(c, 2)                                                            end )
, awful.key( { Super, Shift }, "F3",        function (c) awful.client.movetoscreen(c, 3)                                                            end )
, awful.key( { Super        }, "slash",     function (c) c:swap(awful.client.getmaster())                                                           end )
, awful.key( { Super        }, "Escape",    function (c) c:kill()                                                                                   end )
, awful.key( { Super        }, "n",         function (c) c.minimized = true                                                                         end )
, awful.key( { Super        }, "y",         function (c) c.sticky = not c.sticky                                                                    end )
, awful.key( { Super        }, "g",         function (c) awful.client.floating.toggle()                                                             end )
, awful.key( { Super        }, "t",         function (c) c.ontop = not c.ontop                                                                      end )
, awful.key( { Super        }, "u",         function (c) c.below = not c.below                                                                      end )
, awful.key( { Super        }, "d",         function (c) c.size_hints_honor = not c.size_hints_honor                                                end )
, awful.key( { Super        }, "i",         function (c) c.above = not c.above                                                                      end )
, awful.key( { Super        }, "minus",     function (c) c.maximized_horizontal = not c.maximized_horizontal                                        end )
, awful.key( { Super        }, "backslash", function (c) c.maximized_vertical = not c.maximized_vertical                                            end )
, awful.key( { Super        }, "m",         function (c) c.maximized_horizontal = not c.maximized_horizontal
                                                         c.maximized_vertical = not c.maximized_vertical                                            end )
)
-- }}}
-- Tags manipulation {{{
for i = 1, 9 do
  globalkeys = awful.util.table.join( globalkeys
                                    , awful.key( { Super }, "#"..i + 9
                                               , function ()
                                                   for s = 1, screen.count() do
                                                     local ss = screen.count() + 1 - s
                                                     local tag = awful.tag.gettags(ss)[i]
                                                     if tag then
                                                       awful.tag.viewonly(tag)
                                                     end
                                                   end
                                                 end
                                               )
                                    , awful.key( { Super, Shift }, "#"..i + 9
                                               , function ()
                                                   local tag = awful.tag.gettags(client.focus.screen)[i]
                                                   if client.focus and tag then
                                                     awful.client.toggletag(tag)
                                                   end
                                                 end
                                               )
                                    )
end

-- }}}
-- Mouse buttons {{{
clientbuttons = awful.util.table.join( awful.button( {       }, 1, function (c) client.focus = c; c:raise() end)
                                     , awful.button( { Super }, 1, awful.mouse.client.move )
                                     , awful.button( { Super }, 3, awful.mouse.client.resize )
                                     )
-- }}}
root.keys(globalkeys)
-- }}}
-- Rules {{{
------------------------------------------------------------------------------
awful.rules.rules = { { rule = { }, callback = awful.client.setslave }
                    , { rule = { }, properties = { border_width = beautiful.border_width
                                                 , border_color = beautiful.border_normal
                                                 , focus = awful.client.focus.filter
                                                 , raise = true
                                                 , keys = clientkeys
                                                 , buttons = clientbuttons
                                                 , titlebars_enabled = false
                                                 , placement = awful.placement.no_offscreen
                                                 }
                      }
                    , { rule_any = { class = { "Chromium"
                                             , "Firefox"
                                             }
                                   }
                      , properties = { floating = false
                                     , maximized_horizontal = false
                                     , maximized_vertical = false
                                     }
                      }
                    , { rule_any = { instance = { "DTA"
                                                , "copyq"
                                                }
                                   , class = { "Arandr"
                                             , "Blender"
                                             , "Gpick"
                                             , "feh"
                                             , "Kruler"
                                             , "qt5ct"
                                             , "Sxiv"
                                             , "MessageWin"
                                             , "Wpa_gui"
                                             , "pinentry"
                                             , "veromix"
                                             , "xtightvncviewer"
                                             }
                                   , name = { "Event Tester"
                                            , "Page(s) Unresponsive"
                                            , "Firefox Preferences"
                                            , "Adblock Plus Filter Preferences"
                                            , "Task Manager - Chromium"
                                            }
                                   , role = { "AlarmWindow"
                                            , "pop-up"
                                            }
                                   }
                      , properties = { floating = true }
                      }

                    , { rule_any = { class = { "konsole"
                                             , "URxvt"
                                             , "Zathura"
                                             }
                                   }
                      , properties = { opacity = 1 } --[[ disabled for now ]]
                      }

                    , { rule_any = { class = { "URxvt"
                                             , "XTerm"
                                             }
                                   }
                      , properties = { size_hints_honor = false }
                      }

                    , { rule = { class = "Chromium"    }, properties = { tag = tags[1][1] } }
                    , { rule = { class = "Firefox"     }, properties = { tag = tags[1][2] } }
                    , { rule = { class = "Blender"     }, properties = { tag = tags[1][3] } }
                    , { rule = { class = "Inkscape"    }, properties = { tag = tags[1][4] } }
                    , { rule = { class = "Gimp"        }, properties = { tag = tags[1][5] } }
                    , { rule = { class = "Tor Browser" }, properties = { tag = tags[1][6] } }
                    , { rule = { class = "Arandr"      }, properties = { tag = tags[1][8] } }
                    , { rule = { class = "Spotify"     }, properties = { tag = tags[1][9] } }
                    }
-- }}}
-- Signals {{{
-- signal function to execute when a new client appears {{{
client.connect_signal( "manage", function (c, startup)
  if not startup and not c.size_hints.user_position and not c.size_hints.program_position then
    awful.placement.no_overlap(c)
    awful.placement.no_offscreen(c)
  end
end )
--}}}
-- no border for maximized clients {{{
client.connect_signal( "focus", function(c)
  if c.maximized_horizontal == true and c.maximized_vertical == true then
    c.border_color = beautiful.border_normal
  else
    c.border_color = beautiful.border_focus
  end
end )
client.connect_signal( "unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
-- signal handler {{{
for s = 1, screen.count() do
  screen[s]:connect_signal( "arrange", function ()
    local clients = awful.client.visible(s)
    local layout  = awful.layout.getname(awful.layout.get(s))
    if #clients > 0 then
      for _, c in pairs(clients) do
        if c.fullscreen == true then c.fullscreen = false end               -- disable fullscreen
        if awful.client.floating.get(c) or layout == "floating" then
          c.border_width = beautiful.border_width                         -- floaters always have a boarder
        elseif #clients == 1 then
          clients[1].border_width = 0                                     -- no border for the only client
        else
          c.border_width = beautiful.border_width
        end
      end
    end
  end )
end
-- }}}
-- }}}
