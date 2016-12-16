set background=dark
set termguicolors
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="molokai"
"--------------------------------------------------------------------
set fillchars=vert:\│,fold:_,diff:-
" Default Colors
hi Normal          gui=none       guibg=#000000  guifg=#bbbbbb
hi Special         gui=none       guibg=#000000  guifg=#f58f15
hi SpecialKey                     guibg=#000000  guifg=#de5e1e
hi Directory                      guibg=#000000  guifg=#999999
hi Question                                      guifg=#dddd00
hi SignColumn                     guibg=#333333  guifg=#999999
hi WarningMsg                     guibg=#999999  guifg=#000000
hi Error                          guibg=#eb1d14  guifg=#000000
hi ErrorMsg                       guibg=#eb1d14  guifg=#000000
hi SpellBad        gui=underline  guibg=#eb1d14
hi LineNr                         guibg=#000000  guifg=#de5e1e

hi Cursor                         guibg=#999999  guifg=#000000
hi CursorLine                     guibg=#320800
hi CursorColumn    gui=none       guibg=#240600
hi CursorLineNr                   guibg=#171717  guifg=#ff6600

" Window Elements
hi StatusLine      gui=none       guibg=#171717  guifg=#bbbbbb
hi StatusLineNC    gui=none       guibg=#070707  guifg=#444444
hi VertSplit       gui=none       guibg=#232323  guifg=#232323
hi Folded                         guibg=#171717  guifg=#de5e1e
hi Visual                         guibg=#ff6600  guifg=#111111
hi EndOfBuffer                    guibg=#070707  guifg=#070707

" Completion Popups
hi Pmenu           gui=none       guibg=#232323  guifg=#999999
hi PmenuSel        gui=none       guibg=#232323  guifg=#ff6600
hi PmenuSbar                      guibg=#121212
hi PmenuThumb                     guibg=#232323

hi TabLineFill     gui=underline  guibg=#171717
hi TabLine         gui=underline  guibg=#232323  guifg=#666666
hi TabLineSel      gui=none       guibg=#de5e1e  guifg=#000000

" Search
hi IncSearch       gui=none       guibg=#de1e1e  guifg=#232323
hi Search          gui=none       guibg=#6e1ede  guifg=#000000
hi Substitute      gui=none       guibg=#000000  guifg=#5e1ede

" Specials
hi Todo            gui=none       guibg=#000000  guifg=#eb1d14
hi Title           gui=none       guibg=#171717  guifg=#bbbbbb

" Syntax
hi Constant                                      guifg=#ff6600  
hi Number                                        guifg=#ff541e
hi Boolean                                       guifg=#dddd00
hi cDefine                                       guifg=#dddd00
hi cInclude                                      guifg=#bbbbbb
hi Comment                                       guifg=#555555
hi FoldColumn                     guibg=#232323  guifg=#eb1d14
hi Function                                      guifg=#dddd00
hi Identifier                     guibg=#000000  guifg=#d13800
hi MatchParen      gui=none       guibg=#9ede0e  guifg=#000000
hi ModeMsg                        guibg=#000000  guifg=#de5e1e
hi MoreMsg                        guibg=#000000  guifg=#dddd00
hi NonText                        guibg=#000000  guifg=#ffaa55
hi Operator        gui=none                      guifg=#696969
hi PreProc         gui=none                      guifg=#bbbbbb
hi Statement       gui=bold                      guifg=#de5e1e
hi String          gui=none                      guifg=#d13800
hi Type            gui=none                      guifg=#bbbbbb

" Diff
hi DiffAdd                        guibg=#272727  guifg=#93de1e
hi DiffChange                     guibg=#272727  guifg=#de5e1e
hi DiffDelete                     guibg=#272727  guifg=#eb1d14
hi DiffText                       guibg=#272727  guifg=#bbbbbb

"- end of colorscheme -----------------------------------------------  

