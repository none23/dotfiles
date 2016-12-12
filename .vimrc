" Vim Plug {{{
" Install if not already {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

" }}}
set nocompatible
call plug#begin('~/.vim/plugged')
" Plugins {{{
Plug 'easymotion/vim-easymotion'       " Quickly anywhere without counting words
Plug 'wavded/vim-stylus'               " Stylus support
Plug 'digitaltoad/vim-pug'             " Pug (jade) support
Plug 'vim-airline/vim-airline'         " Airline
Plug 'vim-airline/vim-airline-themes'  " Airline themes
Plug 'majutsushi/tagbar'               " Class/module browser
Plug 'mattn/emmet-vim'                 " Emmet
Plug 'kien/tabman.vim'                 " Tab list panel
Plug 'pangloss/vim-javascript'         " Better JS support
Plug 'ap/vim-css-color'                " CSS colors preview
Plug 'tpope/vim-haml'                  " Sass support
Plug 'kchmck/vim-coffee-script'        " CoffeeScript support
Plug 'ctrlpvim/ctrlp.vim'              " Ctrlp
Plug 'tpope/vim-surround'              " Surround
Plug 'terryma/vim-expand-region'       " Expand region
Plug 'Townk/vim-autoclose'             " Autoclose
Plug 'michaeljsmith/vim-indent-object' " Indent text object
Plug 't9md/vim-choosewin'              " Window chooser
Plug 'scrooloose/syntastic'            " Python and other languages code checker
Plug 'IndexedSearch'                   " Search results counter
Plug 'matchit.zip'                     " XML/HTML tags navigation
Plug 'YankRing.vim'                    " Yank history navigation
Plug 'ervandew/supertab'               " Completion with TAB
Plug 'maksimr/vim-jsbeautify'          " Prettify JS 
Plug 'davidhalter/jedi-vim'            " Jedi-Vim
Plug 'xolox/vim-misc'                  " Sessions
Plug 'xolox/vim-session'
" }}}
call plug#end()

" }}}
" Indentation {{{
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType jade setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType pug setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

set autoindent smartindent

" }}}
" Misc Settings {{{

" status bar
set laststatus=2
set noshowmode

" incremental search
set incsearch

" highlighted search results
set hlsearch

" marker folding
set foldmethod=marker
set foldlevel=0

" syntax highlight
syntax on

" prevent wrapping lines
set textwidth=9999
set nowrap

" when scrolling, keep cursor 9 lines away from screen border
set scrolloff=9

" show line numbers
set number
set relativenumber

" }}}
" Colorscheme {{{

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark
colorscheme nwsome
set cursorline

" highlight 79'th column
set colorcolumn=79
highlight ColorColumn ctermbg=233

" }}}
" Aurocmd on save {{{
" remove trailing whitespace
autocmd FileType python,lua,javascript,json,jsx,coffeescript,jade,pug,html,stylus,css,sass,yaml,zsh,bash autocmd BufWritePre <buffer> %s/\s\+$//e

" autoformat js follow standard
autocmd bufwritepost *.js silent !standard-format -w %
set autoread

" }}}
" Command completion  {{{
"  " autocomplete first menu item
" set wildmenu
" " set completeopt-=preview

" complete only the common part, list the options that match
set wildmode=list:longest

" }}}
" Backup, swap and undos storage {{{

set directory=~/.vim/dirs/tmp     " <=== swap files go here

" turn on backups
set backup                       
set backupdir=~/.vim/dirs/backups " <=== backup files go here

" turn on undo history
set undofile                  
set undodir=~/.vim/dirs/undos     " <=== undo history for every file ever edited go here

set viminfo+=n~/.vim/dirs/viminfo

" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist {{{
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" }}}
" }}}
" Misc mappings {{{
" save with sudo
 ca w!! w !sudo tee "%"

 " save with C-s
nnoremap <C-s> :w<CR>

" indent without loosing focus
vnoremap < <gv
vnoremap > >gv

" command with colon
noremap ; :

"clear search results highlighting
nnoremap <C-L> :nohl<CR><C-L>

" }}}
" Tab navigation {{{
map tt :tabnew<CR>
map tcq :tabc<CR>

map tn :tabn<CR>
map tp :tabp<CR>
map <C-S-Right> :tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Right> <Esc>:tabn<CR>
imap <C-S-Left> <Esc>:tabp<CR>

map tm0 :tabm0<CR>
map tmm :tabm<CR>
" }}}
" Splits navigation {{{
map <F2> :below 10sp term://$SHELL<CR>i
map <F3> :above 10sp term:///usr/bin/ranger<CR>
map <F4> :below 10sp term:///usr/bin/node<CR>i
" map <F4> :below 10sp term:///bin/ipython3<CR>i

" close current split
map <F6> <Esc><C-w>c
" }}}
" Yank/paste to system clipboard {{{
nmap <F8> "+yy
vmap <F8> "+y

nmap <F9> "+p
vmap <F9> "+p

nmap <F7> "+P
vmap <F7> "+P
" }}}
" Reading DOC and PDF files {{{
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.pdf set ro

autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"

" TODO: convert pdf to text on open
" :command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
" }}}
" Plugins settings {{{ 
" EasyMotion {{{
let mapleader = " "       " map leader to space
map <Leader> <Plug>(easymotion-prefix)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward))

" }}}
" ExpandRegion {{{
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" }}}
" Syntastic {{{
" show list of errors and warnings on the current file
nmap ,e :Errors<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['standard']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 1

let g:syntastic_check_on_open = 1
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 1
" custom icons (enable them if you use a patched font, and enable the previous
" setting)
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

" }}}
" TabMan {{{
" mappings to toggle display, and to focus on it
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" }}}
" Autoclose {{{
" fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}
" }}}
" ChooseWin {{{
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 0
let g:choosewin_return_on_single_win = 1

" }}}
" Airline {{{
let g:airline_powerline_fonts=1
let g:airline_theme='simple'

" tab line (off)
let g:airline#extensions#tabline#enabled=0

" }}}
" Neocomplete {{{
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags

autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

autocmd FileType python setlocal omnifunc=python3complete#Complete

autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" }}}
"  Vim Session {{{
" let g:session_autoload = 'no'
let g:session_autosave = 'yes'
"  automatically (silently) save current working session every 5 minutes 
let g:session_autosave_periodic = 5
let g:session_autosave_silent = 1
" when prompting do not include instructions on disabling prompting
let g:session_verbose_messages = 0
" let g:session_autosave = 'no'
" }}}
" }}}

" vim:foldmethod=marker:foldlevel=0
