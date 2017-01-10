# This file is part of ranger, the console file manager.
# License: GNU GPL version 3, see the file "AUTHORS" for details.

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class Default(ColorScheme):
    progress_bar_color = 202

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                bg = red
            if context.border:
                fg = 202
            if context.media:
                if context.image:
                    fg = 166
                else:
                    fg = magenta
            if context.container:
                fg = red
            if context.directory:
                attr |= bold
                fg = 202
            elif context.executable and not \
                    any((context.media, context.container,
                        context.fifo, context.socket)):
                attr |= bold
                fg = 26
            if context.socket:
                fg = magenta
                attr |= bold
            if context.fifo or context.device:
                fg = 166
                if context.device:
                    attr |= bold
            if context.link:
                fg = context.good and 214 or magenta
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (red, magenta):
                    fg = white
                else:
                    fg = red
            if not context.selected and (context.cut or context.copied):
                fg = black
                attr |= bold
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = 166
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = 232
                bg = 202
            elif context.directory:
                fg = 202
            elif context.tab:
                if context.good:
                    bg = 34
            elif context.link:
                fg = 214

        elif context.in_statusbar:
            fg = 0
            bg = 202
            if context.permissions:
                if context.good:
                    bg = 166
                elif context.bad:
                    bg = 160
            if context.marked:
                attr |= bold | reverse
                bg = 25
            if context.message:
                if context.bad:
                    attr |= bold
                    bg = red
            if context.vcsinfo:
                bg = 25
                attr &= ~bold
            if context.vcscommit:
                bg = 34
                attr &= ~bold
            if context.loaded:
                bg = 166

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                bg = 25

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color


        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflict:
                fg = magenta
            elif context.vcschanged:
                fg = red
            elif context.vcsunknown:
                fg = red
            elif context.vcsstaged:
                fg = green
            elif context.vcssync:
                fg = green
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync:
                fg = green
            elif context.vcsbehind:
                fg = red
            elif context.vcsahead:
                fg = 50
            elif context.vcsdiverged:
                fg = magenta
            elif context.vcsunknown:
                fg = red

        return fg, bg, attr
