local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")

theme                     = {}
theme.confdir             = os.getenv("HOME") .. "/.config/awesome"

theme.wallpaper           = theme.confdir .. "/wallpapers/Thing.jpg"
theme.font                = "Inconsolata 9"
theme.font_small          = "Inconsolata 7.5"
theme.tasklist_font       = "Fira Sans 8"
theme.icon_font           = "Ionicons 10"

--[[{{{
--theme.tasklist_spacing    = "6"
theme.taglist_shape = function(cr, width, height)
    gears.shape.losange(cr, width, height)
end
--}}}]]
-- Colors {{{
theme.fg                  = "#999999"
theme.fg_muted            = "#777777"
theme.bg                  = "#000000"
theme.primary             = "#de5e1e"
theme.primary2            = "#ff6000"
theme.secondary           = "#1e9dde"
theme.danger              = "#de1e1e"
theme.black               = "#000000"
theme.tranasparent        = "#00000000"
theme.midgray_0           = "#141414"
theme.midgray_1           = "#232323"
theme.midgray_2           = "#171717"

theme.popup_fg            = "#12121288"
theme.popup_bg            = theme.primary
theme.popup_danger_bg     = "#de1e1e88"
theme.popup_danger_fg     = theme.bg

theme.fg_normal           = theme.fg
theme.fg_focus            = theme.primary2
theme.fg_urgent           = theme.black
theme.menu_fg_normal      = theme.fg
theme.menu_fg_focus       = theme.primary
theme.fg_minimize         = theme.fg
theme.taglist_fg_focus    = theme.primary

theme.bg_normal           = theme.bg
theme.bg_focus            = theme.bg
theme.bg_urgent           = theme.primary
theme.menu_bg_normal      = theme.bg
theme.menu_bg_focus       = theme.bg
theme.bg_minimize         = theme.bg
theme.bg_systray          = theme.bg
theme.prompt_fg = theme.bg
theme.prompt_bg = theme.primary


-- }}}
-- Menu {{{
theme.menu_width          = "120"
theme.menu_height         = "15"
theme.menu_border_width   = "0"

-- }}}
-- Snapping {{{
theme.snap_bg   = theme.primary
theme.snap_border_width   = "2"
theme.snap_shape = function(cr, width, height)
    gears.shape.rectangle(cr, width, height)
end

-- }}}
-- Borders {{{
theme.border_width        = "1"
theme.wibox_border_width  = "0"
theme.widget_border_width = "0"

theme.border_normal       = theme.midgray_1
theme.border_focus        = theme.primary
theme.border_marked       = theme.secondary
theme.gray                = theme.fg

-- }}}
theme.taglist_spacing     = "2"
theme.taglist_shape_border_width = "8"
theme.taglist_squares_sel        = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel      = theme.confdir .. "/icons/square_b.png"

theme.tasklist_align = "center"
-- Powerline {{{
theme.arrow_2L3  = theme.confdir .. "/icons/midgray1_to_primary.svg"
theme.arrow_2L1  = theme.confdir .. "/icons/midgray1_to_midgray0.svg"
theme.arrow_1L2  = theme.confdir .. "/icons/midgray0_to_midgray1.svg"
theme.arrow_0L0  = theme.confdir .. "/icons/black_to_black.svg"
theme.arrow_0L1  = theme.confdir .. "/icons/black_to_midgray0.svg"
theme.arrow_0L2  = theme.confdir .. "/icons/black_to_midgray1.svg"
theme.arrow_0L4  = theme.confdir .. "/icons/black_to_midgray2.svg"
theme.arrow_4L1  = theme.confdir .. "/icons/midgray2_to_midgray0.svg"
theme.arrow_1R0  = theme.confdir .. "/icons/midgray0_to_black_right.svg"
-- }}}
-- Icons {{{
theme.icon_theme                 = nil
theme.tasklist_disable_icon      = true

-- }}}
return theme
