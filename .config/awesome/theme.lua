theme                               = {}

theme.confdir                       = os.getenv("HOME") .. "/.config/awesome"
theme.wallpaper                     = theme.confdir .. "/wallpapers/Thing.jpg"

theme.font                          = "Ubuntu Mono 8"
theme.taglist_font                  = theme.font
theme.menu_bg_normal                = "#222222"
theme.menu_bg_focus                 = "#de5e1e"

theme.bg_normal                     = "#000000"
theme.fg_normal                     = "#cccccc"

theme.bg_focus                      = "#000000"
theme.fg_focus                      = "#de5e1e"

theme.bg_urgent                     = "#de5e1e"
theme.fg_urgent                     = "#000000"

theme.fg_black                      = "#000000"
theme.fg_red                        = "#ff0000"
theme.fg_green                      = "#80a673"
theme.fg_yellow                     = "#ffaf5f"
theme.fg_blue                       = "#1e5ede"
theme.fg_magenta                    = "#94738c"
theme.fg_cyan                       = "#7de2fb"
theme.fg_white                      = "#cccccc"
theme.fg_blu                        = "#8ebdde"

theme.border_width                  = "1"
theme.border_normal                 = "#1c2022"
theme.border_focus                  = "#de5e1e"
theme.border_marked                 = "#3ca4d8"

theme.menu_width                    = "120"
theme.menu_border_width             = "0"
theme.useless_gap_width             = "0"
theme.global_border_width           = "1"

theme.menu_fg_normal                = "#ffffff"
theme.menu_bg_normal                = "#121212"
theme.menu_fg_focus                 = "#000000"
theme.menu_bg_focus                 = "#de5e1e"

theme.widget_greater                = theme.confdir .. "/icons/greater.png"
theme.widget_less                   = theme.confdir .. "/icons/less.png"
theme.widget_less_gray              = theme.confdir .. "/icons/less_gray.png"
theme.widget_triang_left            = theme.confdir .. "/icons/triang_left.png"
theme.widget_triang_right           = theme.confdir .. "/icons/triang_right.png"

theme.widget_cpu                    = theme.confdir .. "/icons/cpu.png"
theme.widget_mem                    = theme.confdir .. "/icons/mem.png"
theme.widget_batt                   = theme.confdir .. "/icons/bat.png"
theme.widget_vol                    = theme.confdir .. "/icons/spkr.png"

theme.taglist_squares_sel           = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel         = theme.confdir .. "/icons/square_b.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

return theme
