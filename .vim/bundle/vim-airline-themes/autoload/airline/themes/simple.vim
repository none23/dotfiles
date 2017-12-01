let g:airline#themes#simple#palette = {}

let s:guibg = '#191919'
let s:guibg2 = '#101010'
let s:termbg = 0
let s:termbg2= 232

let s:N1 = [ s:guibg , '#de5e1e' , s:termbg , 202 ]
let s:N2 = [ '#de5e1e' , s:guibg2, 202 , s:termbg2 ]
let s:N3 = [ '#767676' , s:guibg, 240 , s:termbg]
let g:airline#themes#simple#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#simple#palette.normal_modified = {
      \ 'airline_c': [ '#de5e1e' , s:guibg, 202     , s:termbg    , ''     ] ,
      \ }


let s:I1 = [ s:guibg, '#eb1d14' , s:termbg , 27 ]
let s:I2 = [ '#eb1d14' , s:guibg2, 27 , s:termbg2 ]
let s:I3 = [ '#767676' , s:guibg, 240 , s:termbg ]
let g:airline#themes#simple#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#simple#palette.insert_paste = copy(g:airline#themes#simple#palette.normal_modified)
let g:airline#themes#simple#palette.insert_modified = {
      \ 'airline_a': [ s:I1[0]   , '#1e3ede' , s:I1[2] , 27     , ''     ] ,
      \ }


let g:airline#themes#simple#palette.replace = {
      \ 'airline_a': [ s:I1[0]   , '#af0000' , s:I1[2] , 124     , ''     ] ,
      \ }
let g:airline#themes#simple#palette.replace_modified = copy(g:airline#themes#simple#palette.normal_modified)


let s:V1 = [ s:guibg, '#6b2800' , s:termbg , 160 ]
let s:V2 = [ '#de5e1e' , s:guibg2, 202 , s:termbg2 ]
let s:V3 = [ '#767676' , s:guibg, 240 , s:termbg ]
let g:airline#themes#simple#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#simple#palette.visual_modified = copy(g:airline#themes#simple#palette.normal_modified)


let s:IA  = [ '#3e3e3e' , s:guibg  , 234 , s:termbg  , '' ]
let s:IA2 = [ '#3e3e3e' , s:guibg2 , 234 , s:termbg2 , '' ]
let g:airline#themes#simple#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA2, s:IA2)
let g:airline#themes#simple#palette.inactive_modified = {
      \ 'airline_c': [ '#df0000', '', 160, '', '' ] ,
      \ }
