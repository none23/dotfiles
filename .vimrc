" Vim Plug {{{
scriptencoding utf-8
set encoding=utf-8
" Install if not already {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

" }}}
set nocompatible
call plug#begin('~/.vim/plugged')
" Plugins {{{
" General
Plug 'easymotion/vim-easymotion'      " quickly anywhere without counting words
Plug 'vim-airline/vim-airline'        " airline
Plug 'vim-airline/vim-airline-themes' " airline themes
Plug 'kien/tabman.vim'                " tab list side-panel
Plug 'tpope/vim-surround'             " surround
Plug 'terryma/vim-expand-region'      " expand region
Plug 'Townk/vim-autoclose'            " autoclose
Plug 't9md/vim-choosewin'             " window chooser
Plug 'ervandew/supertab'              " completion with <TAB>
Plug 'YankRing.vim'                   " yank history navigation
Plug 'IndexedSearch'                  " search results counter
Plug 'xolox/vim-misc'                 " sessions dependency
Plug 'xolox/vim-session'              " sessions
Plug 'scrooloose/syntastic'           " linter
" Plug 'matchit.zip'                    " extend '%' to xml/html tags navigation
Plug 'yggdroot/indentline'            " vertical guides for indent levels
Plug 'sheerun/vim-polyglot'           " Syntax highlighting
Plug 'neomake/neomake'
Plug 'junegunn/vim-easy-align'

Plug 'elzr/vim-json'                                   " JSON
Plug 'digitaltoad/vim-pug'                             " Pug (Jade)
Plug 'tpope/vim-haml'                                  " Sass
Plug 'wavded/vim-stylus', { 'for': ['styl'] }          " Stylus
Plug 'kchmck/vim-coffee-script', { 'for': ['coffee'] } " CoffeScript

" Language-specific
Plug 'mattn/emmet-vim'     " emmet
Plug 'ap/vim-css-color'    " css colors preview

Plug 'maksimr/vim-jsbeautify'                                 " Un-minify JS
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " JS code completion
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim'                                        " Parameter completion e.g., .on('cli<tab>
Plug 'moll/vim-node', { 'for': 'javascript' }                 " Open node modules with gf


" " Lint as you type. (off)
" Plug 'neomake/neomake' | Plug 'dojoteef/neomake-autolint'
" g:neomake_autolint_sign_column_always 

" }}}
call plug#end()
let g:polyglot_disabled = ['stylus', 'jade', 'pug', 'javascript', 'json', 'sass', 'scss', 'css', 'coffeescript']

" Easy plugin updates
command! PU PlugUpdate | PlugUpgrade

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
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2

" TODO: language-specific indentation
set autoindent
set nocopyindent
set nopreserveindent
set nosmartindent
set nocindent

" }}}
" Misc Settings {{{

" [experimental] keep the cursor on the same column
set nostartofline

" keep splits equal width / height
set equalalways

" status bar
set laststatus=2
set noshowmode

" substitute with 'g' flag
set gdefault

" incremental search
set incsearch

" no excessive whitespace wthen joining lines 
set nojoinspaces
" case insensitive search
set ignorecase
set smartcase
set infercase

" mouse support
set mouse=a

" highlighted search results
set hlsearch

"  " Don't redraw screen durring macros
" set lazyredraw

" Cursor can move to spaces with no real character in vblock mode.
set virtualedit=block
set synmaxcol=800
set splitbelow
set splitright

" marker folding
set foldmethod=marker
set foldlevel=0
autocmd FileType javascript setlocal foldmethod=syntax

" enable concealing
set conceallevel=1

" vim-javascript conceal settings.
let g:javascript_conceal_function = 'ƒ'
let g:javascript_conceal_arrow_function = "⇒"
let g:javascript_conceal_return = '⇚'
let g:javascript_conceal_this = '@'
let g:javascript_conceal_prototype = '#'
" let g:javascript_conceal_function = "ƒ"
" let g:javascript_conceal_null = "ø"
" let g:javascript_conceal_undefined = "¿"
" let g:javascript_conceal_NaN = "ℕ"
" let g:javascript_conceal_prototype = "¶"
" let g:javascript_conceal_static = "•"
" let g:javascript_conceal_super = "Ω"

set fillchars+=diff:⣿
set diffopt=vertical                  " Use in vertical diff mode
set diffopt+=filler                   " blank lines to keep sides aligned
set diffopt+=iwhite                   " Ignore whitespace changes

" syntax highlight
filetype indent plugin on
syntax on

" prevent wrapping lines
set textwidth=9999
set nowrap

" when scrolling, keep cursor this many lines away from screen border
set scrolloff=9
set sidescrolloff=16

" don't syntax highlight long lines
set synmaxcol=200

" show line numbers
set number
set relativenumber

" ask confirmation instead of failing
set confirm

set fileformats=unix,mac,dos
set fileformat=unix

" }}}
" Colorscheme {{{

set cursorcolumn
set cursorline
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark
colorscheme nwsome

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
set browsedir=buffer           " browse files in same dir as open file
set wildmenu
set wildmode=list:longest,full
set wildignorecase

" Ignore these files for completion
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.jar,*.pyc,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.docx
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=.sass-cache
set wildignore+=.sass-cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*.gem
set wildignore+=*.*~,*~
set wildignore+=*.swp,.lock,.DS_Store,._*,tags.lock
 
set isfname-==

set complete-=i                       " don't complete includes
set complete-=t                       " don't complete tags
set completeopt-=preview              " don't open scratch preview (e.g. echodoc)
set completeopt+=menu,menuone         " show PUM, even for one thing
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

" map leader to space
let mapleader = " "

" toggle concealing
map <leader>c :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

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
let g:syntastic_enable_signs = 1

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
let g:choosewin_return_on_single_win = 0

" }}}
" Airline {{{
let g:airline_powerline_fonts=1
let g:airline_theme='simple'

" tab line
let g:airline#extensions#tabline#enabled = 1

" }}}
" Deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#syntax#min_keyword_length = 3

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [ 'tern#Complete' , 'jspc#omni' ] 
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
let g:SuperTabClosePreviewOnPopupClose = 1

autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" }}}
" Vim Session {{{
let g:session_autosave = 'yes'
" let g:session_autoload = 'no'

" automatically (silently) save current working session every 5 minutes
let g:session_autosave_periodic = 5
let g:session_autosave_silent = 1

" when prompting do not include instructions on disabling prompting
let g:session_verbose_messages = 0
" let g:session_autosave = 'no'

" }}}
" IndentLine {{{
let g:indentLine_color_gui = '#5e231e'
let g:indentLine_char = ':'
let g:indentLine_setConceal = 1
" }}}
" EasyAlign {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
let g:easy_align_interactive_modes = ['l', 'r']
let g:easy_align_bang_interactive_modes = ['c', 'r']

xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"
" <bar> is `|` i.e. <S-backslash>
 nmap <bar> gaip:
" }}}
" }}}


