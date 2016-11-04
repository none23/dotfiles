theme                               = {}
theme.confdir                       = os.getenv("HOME") .. "/.config/awesome"

theme.wallpaper                     = theme.confdir .. "/wallpapers/Thing.jpg"
theme.font                          = "Ubuntu Mono 8"
-- theme.font                          = "Terminess Powerline 7"

theme.fg                            = "#999999"
theme.bg                            = "#000000"
theme.primary                       = "#de5e1e"
theme.secondary                     = "#1e9dde"
theme.danger                        = "#de1e1e"
theme.midgray                       = "#232323"

theme.bg_normal                     = theme.bg
theme.fg_normal                     = theme.fg
theme.bg_focus                      = theme.bg
theme.fg_focus                      = theme.primary
theme.bg_urgent                     = theme.danger
theme.fg_urgent                     = theme.bg
theme.menu_fg_normal                = theme.fg
theme.menu_bg_normal                = theme.bg
theme.menu_fg_focus                 = theme.primary
theme.menu_bg_focus                 = theme.bg
theme.border_normal                 = theme.midgray
theme.border_focus                  = theme.primary
theme.border_marked                 = theme.secondary
theme.gray                          = theme.fg

theme.menu_width                    = "120"
theme.border_width                  = "1"
theme.global_border_width           = "1"
theme.menu_border_width             = "0"
theme.useless_gap_width             = "0"

theme.widget_greater                = theme.confdir .. "/icons/greater.png"
theme.widget_less                   = theme.confdir .. "/icons/less.png"
theme.widget_less_gray              = theme.confdir .. "/icons/less_gray.png"
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
