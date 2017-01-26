-- Requirements {{{
------------------------------------------------------------------------------

local gears     = require("gears")
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
  awful.spawn.with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
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
awful.screen.connect_for_each_screen(function(s)
                                       -- secondary screens
                                       for t = 1, 9 do
                                         s.tags[t].master_count = 1
                                         s.tags[t].column_count = 1
                                         s.tags[t].master_width_factor = 0.625
                                       end

                                       -- primary screen
                                       if s.index == 1 then
                                         s.tags[1].master_count = 1
                                         s.tags[1].column_count = 1
                                         s.tags[1].master_width_factor = 0.85

                                         s.tags[9].master_count = 3
                                         s.tags[9].column_count = 1
                                         s.tags[9].master_width_factor = 0.5

                                         for t = 2, 8 do
                                           s.tags[t].master_count = 1
                                           s.tags[t].column_count = 1
                                           s.tags[t].master_width_factor = 0.75
                                         end
                                       end
                                     end)

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
  local wrapped_inner = wibox.container.margin()
    wrapped_inner:set_top(1)
    wrapped_inner:set_right(margin_right)
    wrapped_inner:set_bottom(1)
    wrapped_inner:set_left(margin_left)
    wrapped_inner:set_widget(target_widget)

  local wrapped_widget = wibox.container.background()
    wrapped_widget:set_widget(wrapped_inner)
    wrapped_widget:set_bg(target_bg)
    wrapped_widget:set_fg(target_fg)

  return wrapped_widget
end

-- icons {{{
local icon_font = beautiful.icon_font

local function wrap_icon (image)
  local wrapped_icon = wibox.container.margin()
    wrapped_icon:set_widget(wibox.widget.imagebox(image))
    wrapped_icon:set_margins(-1)
  return wrapped_icon
end

memicon = wibox.widget.textbox("")
memicon:set_font(icon_font)
memicon_wrap = wrap_widget ( memicon
                           , beautiful.midgray_0  --[[ bg ]]
                           , beautiful.fg         --[[ fg ]]
                           , 2                    --[[ margin-left ]]
                           , 2                    --[[ margin-right ]]
                           )


volumicon_wrap = wrap_widget ( lain.widgets.alsicon({ settings = function()
                                                                   widget:set_font(icon_font)
                                                                   if volume_now.status == "off" then
                                                                     widget:set_text("")
                                                                   elseif tonumber(volume_now.level) > 50 then
                                                                     widget:set_text("")
                                                                   elseif tonumber(volume_now.level) > 15  then
                                                                     widget:set_text("")
                                                                   else
                                                                     widget:set_text("")
                                                                   end
                                                                 end })
                             , beautiful.midgray_1  --[[ bg ]]
                             , beautiful.fg         --[[ fg ]]
                             , 2                    --[[ margin-left ]]
                             , 2                    --[[ margin-right ]]
                             )
bataricon_wrap = wrap_widget ( lain.widgets.bat({ settings = function()
                                                               widget:set_font(icon_font)
                                                               if bat_now.ac_status == 1 then
                                                                 widget:set_text("")
                                                               elseif tonumber(bat_now.perc) >= 80 then
                                                                 widget:set_text("")
                                                               elseif tonumber(bat_now.perc) >= 30 then
                                                                 widget:set_text("")
                                                               else
                                                                 widget:set_text("")
                                                               end
                                                             end })
                             , beautiful.midgray_0  --[[ bg ]]
                             , beautiful.primary    --[[ fg ]]
                             , 4                    --[[ margin-left ]]
                             , 2                    --[[ margin-right ]]
                             ) -- }}}
awful.widget.watch("zsh -c 'print ${$(free --mega)[9]}'",5)
-- memory / cpu {{{
memwidget_wrap = wrap_widget ( awful.widget.watch("zsh -c 'print ${$(free --mega)[9]}'", 10)
                             , beautiful.midgray_0  --[[ bg ]]
                             , beautiful.fg         --[[ fg ]]
                             , 2                    --[[ margin-left ]]
                             , 2                    --[[ margin-right ]]
                             )
cpuwidget_sep = wrap_widget ( wibox.widget.textbox(":")
                            , beautiful.midgray_0  --[[ bg ]]
                            , beautiful.primary    --[[ fg ]]
                            , 0                    --[[ margin-left ]]
                            , 0                    --[[ margin-right ]]
                            )
--[[function cpudata()
        local times = lines_match("cpu","/proc/stat")[1]

        for index,time in pairs(times) do
            local coreid = index - 1
            local core   = cpu.core[coreid] or
                           { last_active = 0 , last_total = 0, usage = 0 }
            local at     = 1
            local idle   = 0
            local total  = 0

            for field in string.gmatch(time, "[%s]+([^%s]+)") do
                -- 4 = idle, 5 = ioWait. Essentially, the CPUs have done
                -- nothing during these times.
                if at == 4 or at == 5 then
                    idle = idle + field
                end
                total = total + field
                at = at + 1
            end

            local active = total - idle

            if core.last_active ~= active or core.last_total ~= total then
                -- Read current data and calculate relative values.
                local dactive = active - core.last_active
                local dtotal  = total - core.last_total
                local usage   = math.ceil((dactive / dtotal) * 100)

                core.last_active = active
                core.last_total  = total
                core.usage       = usage

                -- Save current data for the next run.
                cpu.core[coreid] = core
            end
        end
end]]

cpuwidget_wrap = wrap_widget ( lain.widgets.cpu({ settings = function()
                                                               widget:set_text(cpu_now.usage)
                                                             end })
                             , beautiful.midgray_0  --[[ bg ]]
                             , beautiful.primary    --[[ fg ]]
                             , 2                    --[[ margin-left ]]
                             , 4                    --[[ margin-right ]]
                             ) -- }}}
-- alsa volume {{{

volumewidget = lain.widgets.alsa({ settings = function() widget:set_text(volume_now.level .. "%") end })

volumewidget_wrap = wrap_widget ( volumewidget
                                , beautiful.midgray_1  --[[ bg ]]
                                , beautiful.fg         --[[ fg ]]
                                , 2                    --[[ margin-left ]]
                                , 4                    --[[ margin-right ]]
                                ) -- }}}
-- battery {{{
batwidget_wrap = wrap_widget ( lain.widgets.bat({ settings = function()
                                                               widget:set_text(bat_now.perc .. "%")
                                                             end })
                             , beautiful.midgray_0  --[[ bg ]]
                             , beautiful.primary    --[[ fg ]]
                             , 2                    --[[ margin-left ]]
                             , 4                    --[[ margin-right ]]
                             ) -- }}}
-- date {{{
datewidget_wrap = wrap_widget ( wibox.widget.textclock( '<span>' ..  tostring("%d-%a") ..  '</span>', 100)
                              , beautiful.midgray_1  --[[ bg ]]
                              , beautiful.fg         --[[ fg ]]
                              , 3                    --[[ margin-left ]]
                              , 2                    --[[ margin-right ]]
                              ) -- }}}
-- clock {{{
clockwidget_wrap = wrap_widget ( wibox.widget.textclock( '<span>' ..  tostring("%H:%M") ..  '</span>', 10)
                               , beautiful.primary    --[[ bg ]]
                               , beautiful.black      --[[ fg ]]
                               , 2                    --[[ margin-left ]]
                               , 5                    --[[ margin-right ]]
                               ) -- }}}
-- arrows {{{
--[[---------------- ARROW SEPARATORS NAMING: ------------------------------#
│                                     │                                     │
│         ╭―――― points left           │        ╭―――― points right           │
│         ▼                           │        ▼                            │
│  arrow_1L2                          │ arrow_0R1                           │
│        ▲ ▲                          │       ▲ ▲                           │
│        │ ╰――― right half is color'2'│       │ ╰――― right half is color '1'│
│        ╰――――― left half is '1'      │       ╰――――― left half is color '0' │
│                                     │                                     │
#-------------------------------------#------------------------------------]]

arrow_2L3 = wrap_icon(beautiful.arrow_2L3)
arrow_2L1 = wrap_icon(beautiful.arrow_2L1)
arrow_1L2 = wrap_icon(beautiful.arrow_1L2)
arrow_0L1 = wrap_icon(beautiful.arrow_0L1)
arrow_1R0 = wrap_icon(beautiful.arrow_1R0)

-- }}}
-- promptbox {{{
local mypromptbox = awful.prompt.run { prompt = "Run:", exe_callback = function (input)
                                                                         if not input or #input == 0 then return end
                                                                         awful.spawn.with_shell(input)
                                                                       end }
-- }}}
-- }}}
-- Wibox {{{
-- buttons {{{

mytaglist_buttons = awful.util.table.join( awful.button({ },       1, awful.tag.viewonly)
                                         , awful.button({ },       3, awful.tag.viewtoggle)
                                         , awful.button({ Super }, 1, awful.client.movetotag)
                                         , awful.button({ Super }, 3, awful.client.toggletag)
                                         )

mytasklist_buttons = awful.util.table.join( awful.button( { }, 1 , function (c)
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
awful.screen.connect_for_each_screen(function(s)

  s.mypromptbox = awful.widget.prompt()
  s.mytaglist = awful.widget.taglist( s
                                    , awful.widget.taglist.filter.all
                                    , mytaglist_buttons
                                    )

  s.taglist_wrap = wibox.container.background()
    s.taglist_wrap:set_widget(s.mytaglist)
    s.taglist_wrap:set_bg(beautiful.midgray_0)


  s.mytasklist = awful.widget.tasklist( s
                                      , awful.widget.tasklist.filter.currenttags
                                      , mytasklist_buttons
                                      )

  s.mywibox = awful.wibar({ position = "top"
                          , screen = s
                          , height = 16
                          })
  -- Left {{{
  s.promptbox_wrap = wibox.container.background()
    s.promptbox_wrap:set_widget(s.mypromptbox)
    s.promptbox_wrap:set_bg(beautiful.midgray_0)

  s.left_layout = wibox.layout.fixed.horizontal()
    s.left_layout:add(s.taglist_wrap)
    s.left_layout:add(s.promptbox_wrap)
    s.left_layout:add(arrow_1R0)

    -- }}}
    -- Right {{{
    s.right_layout = wibox.layout.fixed.horizontal()

      -- systray
      s.right_layout:add(wibox.widget.systray())

      -- mem / cpu state
      s.right_layout:add(arrow_0L1)
      s.right_layout:add(memicon_wrap)
      s.right_layout:add(memwidget_wrap)
      s.right_layout:add(cpuwidget_sep)
      s.right_layout:add(cpuwidget_wrap)

      -- volume
      s.right_layout:add(arrow_1L2)
      s.right_layout:add(volumicon_wrap)
      s.right_layout:add(volumewidget_wrap)

      -- battery
      s.right_layout:add(arrow_2L1)
      s.right_layout:add(bataricon_wrap)
      s.right_layout:add(batwidget_wrap)

      -- date
      s.right_layout:add(arrow_1L2)
      s.right_layout:add(datewidget_wrap)

      -- time
      s.right_layout:add(arrow_2L3)
      s.right_layout:add(clockwidget_wrap)

    -- }}}
    -- Bring it all together {{{

   s.layout = wibox.layout.align.horizontal()

      s.layout:set_left( s.left_layout)
      s.layout:set_middle( s.mytasklist )
      s.layout:set_right( s.right_layout)

    s.mywibox:set_widget(s.layout)

    -- }}}
end)
-- }}}
-- Keybindings {{{
-- Global keybindings {{{
globalkeys = awful.util.table.join(
  awful.key( { Super        }, "h",        function () awful.client.focus.global_bydirection("left") if client.focus then client.focus:raise() end  end )
, awful.key( { Super        }, "j",        function () awful.client.focus.global_bydirection("down") if client.focus then client.focus:raise() end  end )
, awful.key( { Super        }, "k",        function () awful.client.focus.global_bydirection("up") if client.focus then client.focus:raise() end    end )
, awful.key( { Super        }, "l",        function () awful.client.focus.global_bydirection("right") if client.focus then client.focus:raise() end end )
, awful.key( { Super        }, "w",        function () awful.client.focus.byidx(1) if client.focus then client.focus:raise() end                    end )
, awful.key( { Super, Cntrl }, "w",        function () awful.client.cycle({clockwise=true})                                                         end )
, awful.key( { Super        }, "b",        function () awful.client.focus.history.previous() if client.focus then client.focus:raise() end          end )
, awful.key( { Super, Shift }, "j",        function () awful.client.swap.global_bydirection("down")                                                 end )
, awful.key( { Super, Shift }, "k",        function () awful.client.swap.global_bydirection("up")                                                   end )
, awful.key( { Super, Shift }, "h",        function () awful.client.swap.global_bydirection("left")                                                 end )
, awful.key( { Super, Shift }, "l",        function () awful.client.swap.global_bydirection("right")                                                end )
, awful.key( { Super        }, "a",        function () awful.client.restore()                                                                       end )
, awful.key( { Super        }, "x",        function () awful.screen.focused().mypromptbox:run()                                                     end )
, awful.key( { Super        }, "z",        function () menubar.show()                                                                               end )
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
, awful.key( { Super        }, "Return",   function () awful.util.spawn("konsole -e zsh")                                                           end )
, awful.key( { Super, Cntrl }, "Return",   function () awful.util.spawn("urxvt")                                                                    end )
, awful.key( { Super        }, "KP_Enter", function () awful.util.spawn("konsole -e zsh")                                                           end )
, awful.key( { Super, Cntrl }, "KP_Enter", function () awful.util.spawn("urxvt")                                                                    end )

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
                                    , awful.key( { Super, Cntrl }, "#"..i + 9
                                               , function ()
                                                   local tag = awful.screen.focused().tags[i]
                                                   if tag then
                                                     tag:view_only()
                                                   end
                                                 end
                                               )

                                    , awful.key( { Super }, "#"..i + 9
                                               , function ()
                                                   for a_screen in screen do
                                                     local tag = a_screen.tags[i]
                                                     if tag then
                                                       tag:view_only()
                                                     end
                                                   end
                                                 end
                                               )

                                    , awful.key( { Super, Shift }, "#"..i + 9
                                               , function ()
                                                   local tag = awful.screen.focused().tags[i]
                                                   if awful.client.focus and tag then
                                                     awful.client.toggletag(tag)
                                                   end
                                                 end
                                               )

                                    , awful.key( { Super, Shift, Cntrl }, "#"..i + 9
                                               , function ()
                                                   local all_clients = awful.screen.focused().selected_tag:clients()
                                                   local tag = awful.screen.focused().tags[i]
                                                   if all_clients then
                                                     for _, a_client in ipairs(all_clients) do
                                                       local tagset = a_client:tags()
                                                       local toggled = false
                                                       for tag_index, tag_key in ipairs(tagset) do
                                                         if tag_key == tag then
                                                           table.remove(tagset, tag_index)
                                                           a_client:tags(tagset)
                                                           toggled = true
                                                         end
                                                       end
                                                       if not toggled then
                                                         table.insert(tagset, tag)
                                                         a_client:tags(tagset)
                                                       end
                                                     end
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
                                             , "Octave"
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
                    , { rule = { class = "Blender"     }, properties = { tag = tags[1][3] } }
                    , { rule = { class = "Inkscape"    }, properties = { tag = tags[1][4] } }
                    , { rule = { class = "Gimp"        }, properties = { tag = tags[1][5] } }
                    , { rule = { class = "Tor Browser" }, properties = { tag = tags[1][6] } }
                    , { rule = { class = "Arandr"      }, properties = { tag = tags[1][8] } }
                    , { rule = { class = "Firefox"     }, properties = { tag = tags[1][9] } }
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
