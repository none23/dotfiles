let g:airline#themes#simple#palette = {}

let s:black  = '#000000'
let s:gray1  = '#111111'
let s:gray2  = '#191919'
let s:gray3  = '#232323'
let s:gray4  = '#272727'
let s:gray5  = '#333333'
let s:gray6  = '#444444'
let s:gray7  = '#555555'
let s:gray8  = '#777777'
let s:gray9  = '#999999'
let s:white  = '#cccccc'
let s:orange = '#de5e1e'
let s:blue1  = '#1e5ed0'
let s:blue2  = '#233299'
let s:red1   = '#eb1d14'
let s:red2   = '#af0000'
let s:green  = '#233299'
let s:yellow = '#de9e00'


let g:airline#themes#simple#palette.normal = airline#themes#generate_color_map( [ s:gray2, s:orange ,'' ,'' ], [ s:orange , s:gray1 , '' , '' ], [ s:gray8 , s:gray2 , '' , '' ])
let g:airline#themes#simple#palette.normal_modified = {'airline_a': [ s:black , s:orange , '' , '' , '' ], 'airline_c': [ s:red1 , s:gray2 , '' , '' , '' ] }

let g:airline#themes#simple#palette.insert = airline#themes#generate_color_map([ s:gray1 , s:blue1 , '' , '' ], [ s:blue2 , s:gray1 , '' , '' ], [ s:gray8 , s:gray2 , '' , '' ])
let g:airline#themes#simple#palette.insert_paste = copy(g:airline#themes#simple#palette.normal_modified)
let g:airline#themes#simple#palette.insert_modified = {'airline_a': [ s:gray1, s:blue1, '', '', '' ]}

let g:airline#themes#simple#palette.replace = {'airline_a': [ s:gray1, s:red2, '', '', '' ]}
let g:airline#themes#simple#palette.replace_modified = copy(g:airline#themes#simple#palette.normal_modified)
let g:airline#themes#simple#palette.visual = airline#themes#generate_color_map([ s:yellow, s:gray2, '', '' ], [ s:black, s:yellow, '', '' ], [ s:yellow, s:gray2, '', '' ])
let g:airline#themes#simple#palette.visual_modified = copy(g:airline#themes#simple#palette.normal_modified)

let g:airline#themes#simple#palette.inactive = airline#themes#generate_color_map([ s:gray4, s:gray2, '', '', ''], [ s:gray4, s:gray1, '', '', ''], [ s:gray4, s:gray1, '', '', ''])
let g:airline#themes#simple#palette.inactive_modified = {'airline_c': [ s:red1, '', '', '', '' ]}
