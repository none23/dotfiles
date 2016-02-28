set nocompatible
" Vundle {{{
filetype off
" Set up Vundle if not installed {{{
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
" }}}
set rtp+=~/.vim/bundle/vundle/
" Vundle Plugins {{{
call vundle#rc()
" let Vundle manage Vundle
Plugin 'gmarik/vundle'
" Quickly anywhere without counting words
Plugin 'easymotion/vim-easymotion'
" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Class/module browser
Plugin 'majutsushi/tagbar'
" Zen coding
Plugin 'mattn/emmet-vim'
" Tab list panel
Plugin 'kien/tabman.vim'
" Surround
Plugin 'tpope/vim-surround'
" Expand region
Plugin 'terryma/vim-expand-region'
" Autoclose
Plugin 'Townk/vim-autoclose'
" Indent text object
Plugin 'michaeljsmith/vim-indent-object'
" Python mode (indentation, doc, refactor, lints, code checking, motion and
" operators, highlighting, run and ipdb breakpoints)
Plugin 'klen/python-mode'
" Better autocompletion
" Plugin 'Shougo/neocomplete.vim' -- doesn't work in neovim
" Window chooser
Plugin 't9md/vim-choosewin'
" Python and other languages code checker
Plugin 'scrooloose/syntastic'
" Search results counter
Plugin 'IndexedSearch'
" XML/HTML tags navigation
Plugin 'matchit.zip'
" Yank history navigation
Plugin 'YankRing.vim'
" Completion with TAB
Plugin 'ervandew/supertab'
" Jedi-Vim
Plugin 'davidhalter/jedi-vim'
" Restore vim sessions
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
" }}}
" Install plugins the first time vim runs {{{
if iCanHazVundle == 0
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
" }}}
filetype plugin on
filetype indent on
" }}}

" Neovim Settings and Mappings {{{

" Indentation {{{
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
" }}}

" Misc options {{{
" status bar
set laststatus=2
set noshowmode

" incremental search
set incsearch

" highlighted search results
set hlsearch

" syntax highlight on
syntax on

" text width
set tw=80 "width

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=7

" show line numbers
set number
set relativenumber
set autoindent smartindent
" }}}

" Colorscheme {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
colorscheme nwsome
set cursorline

" highlight 79'th column
set colorcolumn=79
highlight ColorColumn ctermbg=233
" }}}

" Autocompletion {{{
set wildmenu
" set completeopt-=preview

" complete only the common part, list the options that match
set wildmode=list:full
" }}}

" Backup, swap and undos storage {{{
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
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

" indent without loosing focus
vnoremap < <gv
vnoremap > >gv

" command with colon
noremap ; :

"clear search results highlighting
nnoremap <C-L> :nohl<CR><C-L>

" map leader to space
let mapleader = " "
" }}}

" Tab navigation {{{
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm<CR>
map tt :tabnew<CR>
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <Esc>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <Esc>:tabp<CR>
" }}}

" Splits navigation {{{
map <F2> :below 10sp term://$SHELL<CR>i
map <F3> :above 10sp term:///usr/bin/ranger<CR>
map <F4> :below 10sp term:///bin/ipython3<CR>i

" TODO: leave terminal-mode with <F5>

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

" MS Windows Documents {{{
" opening read-only and decoding
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"
" }}}

" Plugins Settings and Mappings {{{

" "  Tagbar (off) {{{
" " toggle tagbar display
" map <S-F1> :TagbarToggle<CR>
" map <S-F13> :TagbarToggle<CR>
" " autofocus on tagbar open
" let g:tagbar_autofocus = 0
" " }}}

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

" NERDTree (off) {{{
"  " toggle nerdtree display
" map <F3> :NERDTreeToggle<CR>
"  " open nerdtree with the current file selected
" nmap ,t :NERDTreeFind<CR>
"  " don;t show these file types
" let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
" }}}

" Syntastic {{{
" show list of errors and warnings on the current file
nmap ,e :Errors<CR>
" check also when just opened the file
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

" Python-mode {{{
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
let pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_virtualenv = 1
nmap ,D :tab split<CR>:PymodePython rope.goto()<CR>
nmap ,o :RopeFindOccurrences<CR>
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

" Window Chooser {{{
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1
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

" Airline {{{
let g:airline_powerline_fonts=1
let g:airline_theme='simple'

" tab line (off)
let g:airline#extensions#tabline#enabled=0
" }}}

"  Vim Session {{{
let g:session_autoload = 'no'
let g:session_autosave = 'no'
" }}}
" }}}

" Neovim-qt Settings {{{

" Neovim-qt Guifont command
command -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"

" Set the font
Guifont Terminess Powerline:h9

" }}}

" vim:foldmethod=marker:foldlevel=0
