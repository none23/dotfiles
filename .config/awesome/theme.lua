theme                   = {}
theme.confdir           = os.getenv("HOME") .. "/.config/awesome"

theme.wallpaper         = theme.confdir .. "/wallpapers/Thing.jpg"
theme.font              = "Ubuntu Mono 8"
--theme.font              = "Terminess Powerline 7"
theme.taglist_font      = theme.font

theme.fg                = "#999999"
theme.bg                = "#000000"
theme.primary           = "#de5e1e"
theme.primary2          = "#ff5500"
theme.secondary         = "#1e9dde"
theme.danger            = "#de1e1e"
theme.black             = "#000000"
theme.tranasparent      = "#00000000"
theme.midgray_0         = "#121212"
theme.midgray_1         = "#232323"
theme.midgray_2         = "#474747"

theme.border_width        = "1"
theme.wibox_border_width  = "0"
theme.widget_border_width = "0"
theme.menu_width          = "120"
theme.menu_height         = "15"
theme.menu_border_width   = "0"

theme.fg_normal         = theme.fg
theme.fg_focus          = theme.primary2
theme.fg_urgent         = theme.black
theme.menu_fg_normal    = theme.fg
theme.menu_fg_focus     = theme.primary
theme.fg_minimize       = theme.fg
theme.taglist_fg_focus  = theme.primary

theme.bg_normal         = theme.bg
theme.bg_focus          = theme.bg
theme.bg_urgent         = theme.danger
theme.menu_bg_normal    = theme.bg
theme.menu_bg_focus     = theme.bg
theme.bg_minimize       = theme.bg
theme.bg_systray        = theme.bg

theme.border_normal     = theme.midgray_1
theme.border_focus      = theme.primary
theme.border_marked     = theme.secondary
theme.gray              = theme.fg

-- Icons {{{

theme.widget_greater                = theme.confdir .. "/icons/greater.png"
theme.widget_less                   = theme.confdir .. "/icons/less.png"
theme.widget_less_gray              = theme.confdir .. "/icons/less_gray.png"
theme.widget_cpu                    = theme.confdir .. "/icons/cpu.png"
theme.widget_mem                    = theme.confdir .. "/icons/mem.png"
theme.widget_batt                   = theme.confdir .. "/icons/bat.png"
theme.widget_vol                    = theme.confdir .. "/icons/spkr.png"
theme.taglist_squares_sel           = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel         = theme.confdir .. "/icons/square_b.png"

theme.powerline_left_orange         = theme.confdir .. "/icons/powerline_left_orange.png"
theme.powerline_left_orange_long    = theme.confdir .. "/icons/powerline_left_orange_long.png"
theme.powerline_left_gray           = theme.confdir .. "/icons/powerline_left_gray.png"
theme.powerline_left_gray_long      = theme.confdir .. "/icons/powerline_left_gray_long.png"

theme.icon_theme                    = nil
theme.tasklist_disable_icon         = true

-- }}}

return theme
