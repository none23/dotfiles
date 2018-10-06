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

Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/tabman.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-expand-region'
" Plug 't9md/vim-choosewin'
Plug 'ervandew/supertab'
Plug 'vim-scripts/IndexedSearch'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
" Plug 'elzr/vim-json', { 'for': ['json'] }
" Plug 'jparise/vim-graphql'
" Plug 'digitaltoad/vim-pug'
" Plug 'tpope/vim-haml'
Plug 'hhsnopek/vim-sugarss'
Plug 'ap/vim-css-color'
" Plug 'wavded/vim-stylus', { 'for': ['stylus'] }
" Plug 'kewah/vim-stylefmt', { 'for': ['css', 'scss', 'stylus', 'sugarss'] }
" Plug 'alampros/vim-styled-jsx', { 'for': ['javascript', 'javascript.jsx'] }

" Plug 'mattn/webapi-vim' " <----------╮
" Plug 'mattn/gist-vim' " dependancy --╯

Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'

Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'none23/autocomplete-flow'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'flowtype/vim-flow', { 'for': ['javascript', 'javascript.jsx'] }

" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'

" Plug 'xolox/vim-misc' " <---------------╮
" Plug 'xolox/vim-session' " dependancy --╯

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plug 'Olical/vim-enmasse'                 " Edit all files in a Quickfix list
" Plug 'jiangmiao/auto-pairs'

call plug#end()

" Easy plugin updates
command! PU PlugUpdate | PlugUpgrade

" }}}

" Indentation {{{
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set autoindent
set nocopyindent
set nopreserveindent
set nosmartindent
set nocindent

" }}}
"
" Misc Settings {{{
" set splitbelow
set splitright
set cmdheight=1

" (OFF) cd to file directory automatically
set noautochdir

" [experimental] keep the cursor on the same column
set nostartofline

" keep splits equal width (but not height)
set equalalways
set winfixheight

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

" don't redraw screen durring macros
set lazyredraw

" cursor can move to spaces with no real character in vblock mode.
set virtualedit=block

" folding
set foldmethod=syntax
set foldlevel=999
autocmd FileType zsh,bash,shell,vim setlocal foldmethod=marker

" enable concealment
set conceallevel=1
let g:javascript_conceal_function = 'ƒ'
let g:javascript_conceal_arrow_function = "⇒"
" let g:javascript_conceal_return = '⇚'
" let g:javascript_conceal_this = '@'
" let g:javascript_conceal_null = "ø"
" let g:javascript_conceal_undefined = "¿"
" let g:javascript_conceal_NaN = "ℕ"
" let g:javascript_conceal_prototype = "¶"
" let g:javascript_conceal_static = "•"
" let g:javascript_conceal_super = "Ω"

" diff-mode
set diffopt=vertical
set diffopt+=filler " blank lines to keep sides aligned
set diffopt+=iwhite " ignore whitespace changes
set fillchars+=diff:┈

" syntax highlight
filetype indent plugin on
syntax on

" remove trailing whitespace on save
autocmd FileType javascript,json,typescript autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType lua autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType jade,pug autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType html,svg,xml autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType css,sugarss,stylus,scss,sass autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType zsh,bash,sh autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType yaml autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType python autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType sql,pgsql autocmd BufWritePre <buffer> %s/\s\+$//e

set autoread

" prevent wrapping lines
set textwidth=100
set nowrap

" when scrolling, keep cursor this many lines away from screen border
set scrolloff=9
set sidescrolloff=9

" don't syntax highlight long lines
set synmaxcol=220

" show line numbers
set number
set relativenumber

" ask confirmation instead of failing
set confirm

set fileformats=unix,mac,dos
set fileformat=unix

" }}}

" Colors {{{
set cursorcolumn
set cursorline

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set termguicolors

set background=dark

colorscheme nwsome

" highlight 80'th column
set colorcolumn=80

" highlight 100'th column
set colorcolumn=100

" }}}
"
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
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*.gem
set wildignore+=*.*~,*~
set wildignore+=*.swp,.lock,.DS_Store,._*,tags.lock
set isfname-==
set completeopt=longest,menuone
" set completeopt-=preview              " don't open scratch preview (e.g. echodoc)
" set completeopt+=menu,menuone         " show PUM, even for one thing
" set complete-=i                       " don't complete includes
" set complete-=t                       " don't complete tags

" }}}

" Backup, swap and undos storage {{{
set directory=~/.vim/dirs/tmp

" turn on backups
set backup
set backupdir=~/.vim/dirs/backups

" turn on undo history
set undofile
set undodir=~/.vim/dirs/undos

set viminfo+=n~/.vim/dirs/viminfo

" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist
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
nnoremap <C-l> :nohl<CR><C-l>

" set <Leader> key
let mapleader = " "

" toggle concealing
map <Leader>c :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

" sort lines
map <Leader>o vv:sort<CR>

" move curent line's last character to the next line
map <Leader>q $i<CR><Esc>J

" escape key in terminal
:tnoremap <Esc><Esc> <C-\><C-n>

" run macro on selected lines
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction


" stop using arrows in normal mode
noremap <Up> <C-w>w
noremap <Down> <C-w>W
noremap <Left> :tabp<CR>
noremap <Right> :tabn<CR>

" buffer navigation
map <C-Up> :bnext<CR>
map <C-Down> :bNext<CR>

" tab navigation
map tt :tabnew<CR>
map tn :tabn<CR>
map tp :tabp<CR>

" term-mode
map <F2> :below 10sp term://$SHELL<CR>i
map <F4> :below 10sp term:///usr/bin/node<CR>i

" yank to system clipboard
nmap <F8> "+yy
vmap <F8> "+y
nmap <F7> "+P
vmap <F7> "+P
nmap <F9> "+p
vmap <F9> "+p

" }}}

" Read .doc files {{{
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"

" }}}

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

" TabMan {{{
" mappings to toggle display, and to focus on it
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" }}}

" TernJS {{{
" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

let g:tern_show_signature_in_pum = 1
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" }}}

" VimJSON {{{
let g:vim_json_syntax_conceal=1
autocmd FileType json let g:vim_json_syntax_conceal=1

" }}}

" ChooseWin {{{
let g:choosewin_overlay_enable = 0
let g:choosewin_statusline_replace = 1
let g:choosewin_return_on_single_win = 1

let g:choosewin_color_label =           { 'gui': ['#111111', '#ffffff'], 'cterm': [235, 250, 'bold'] }
let g:choosewin_color_label_current =   { 'gui': ['#ff6600', '#000000'], 'cterm': [202, 233, 'bold'] }
let g:choosewin_color_land =            { 'gui': ['#ff6600', '#000000'], 'cterm': [202, 233] }
let g:choosewin_color_other =           { 'gui': ['#111111', '#000000'], 'cterm': [235, 233] }
let g:choosewin_color_overlay =         { 'gui': ['#111111', '#ffffff'], 'cterm': [235, 250] }
let g:choosewin_color_overlay_current = { 'gui': ['#ff6600', '#000000'], 'cterm': [202, 233] }
nmap  <C-w><Leader>  <Plug>(choosewin)

" }}}

" Airline {{{
let g:airline_powerline_fonts=1
let g:airline_theme='simple'

" tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnametruncate = 6

"tab numbers
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" }}}

" Deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#syntax#min_keyword_length = 2
" let g:deoplete#auto_complete_delay = 10
" let g:deoplete#max_list = 3000
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]
let g:deoplete#sources = {}
let g:deoplete#sources['javascript'] = ['ultisnips', 'flow', 'ternjs', 'arround', 'buffer']
" let g:deoplete#sources['javascript'] = ['ultisnips', 'ternjs', 'flow', 'buffer']
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" }}}

" Autocomplete-flow{{{
let g:autocomplete_flow#insert_paren_after_function = 0

" }}}

" Neosnippet{{{
" let g:neosnippet#enable_completed_snippet = 1

" SuperTab like snippets behavior.
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" }}}

" SuperTab {{{
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
let g:SuperTabClosePreviewOnPopupClose = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" }}}

" EasyAlign {{{
" start interactive EasyAlign in visual mode (e.g. vipga)
let g:easy_align_interactive_modes = ['l', 'r']
let g:easy_align_bang_interactive_modes = ['c', 'r']
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" }}}

" Emmet {{{
let g:user_emmet_mode='a'
let g:user_emmet_install_global = 0
autocmd FileType html,javascript.jsx EmmetInstall

" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger="<C-j>"

" }}}

" ALE {{{
" let g:ale_set_baloons = 1
" let g:ale_set_quickfix = 1
let g:ale_set_loclist = 1
let g:ale_keep_list_window_open = 1
let g:ale_list_window_size = 6
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_enter = 0
" g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = -1
let g:ale_change_sign_column_color = 0
let g:ale_sign_column_always = 1
let g:ale_set_signs = 1
let g:ale_open_list = 1
let g:ale_echo_cursor = 1
" let g:ale_cursor_detail = 1
let g:ale_echo_msg_format = '%s (%linter%) - %[code]%'


" let g:ale_linters = { 'javascript': ['flow', 'eslint', 'stylelint'] }
let g:ale_linters = { 'javascript': ['flow', 'eslint'] }
let g:ale_javascript_eslint_suppress_eslintignore = 1
let g:ale_javascript_eslint_suppress_missing_config = 1
let g:ale_javascript_prettier_use_local_config = 1

let g:ale_fix_on_save = 1

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']

nnoremap ,e :ALENextWrap<cr>
nnoremap ,d :ALEFindReferences<cr>
nnoremap ,i :ALEDetail<cr>
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

let g:ale_echo_msg_error_str = '🔥'
let g:ale_echo_msg_warning_str = '💩'
let g:ale_echo_msg_info_str = '💬'
let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '💩'
let g:ale_sign_style_error = '⚑'
let g:ale_sign_style_warning = '⚐'
let g:ale_sign_info = 'i'

" }}}

" Fzf {{{
nnoremap <C-p> :FZF<CR>

" }}}

" Ack {{{
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" }}}

" Gist {{{
" let g:gist_browser_command = 'chromium %URL%'
" let g:gist_clip_command = 'xclip -selection clipboard'

" }}}

" Fugitive {{{
" set statusline+=%{fugitive#statusline()} 

" }}}

autocmd QuickFixCmdPost *grep* cwindow

" NERDTree {{{
let NERDTreeShowHidden=1
nmap <F5> :NERDTreeToggle<CR>

" }}}

" Vim Session {{{
let g:session_autosave = 'yes'

" automatically (silently) save current working session every 5 minutes
let g:session_autosave_periodic = 5
let g:session_autosave_silent = 1

" when prompting do not include instructions on disabling prompting
let g:session_verbose_messages = 0

let g:session_autosave = 'no'
let g:session_autoload = 'no'

" }}}

" vim:syntax=vim
