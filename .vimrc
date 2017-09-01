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
Plug 'terryma/vim-expand-region'
Plug 't9md/vim-choosewin'
Plug 'ervandew/supertab'
Plug 'vim-scripts/IndexedSearch'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'

Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'elzr/vim-json', { 'for': ['json'] }
Plug 'jparise/vim-graphql'
Plug 'digitaltoad/vim-pug'
Plug 'tpope/vim-haml'
Plug 'hhsnopek/vim-sugarss'
Plug 'ap/vim-css-color'
Plug 'wavded/vim-stylus', { 'for': ['stylus'] }
Plug 'kewah/vim-stylefmt', { 'for': ['css', 'scss', 'sass', 'stylus', 'sugarss'] }

Plug 'mattn/webapi-vim' " <----------╮
Plug 'mattn/gist-vim' " dependancy --╯

Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'

Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'alexlafroscia/deoplete-flow',       { 'branch': 'pass-filename-to-autocomplete' }

" Plug 'Olical/vim-enmasse'                 " Edit all files in a Quickfix list

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'jiangmiao/auto-pairs'
" Plug 'roxma/nvim-completion-manager'
" Plug 'roxma/nvim-cm-tern',  { 'do': 'npm install' }
" Plug 'roxma/ncm-flow'
" Plug 'xolox/vim-misc' " <---------------╮
" Plug 'xolox/vim-session' " dependancy --╯

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
" Misc Settings {{{
" (OFF) cd to file directory automatically
set noautochdir

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
set mouse=v

" highlighted search results
set hlsearch

"  " Don't redraw screen durring macros
set lazyredraw

" Cursor can move to spaces with no real character in vblock mode.
set virtualedit=block
set synmaxcol=200
set splitbelow
set splitright

" marker folding
set foldmethod=marker
set foldlevel=999
autocmd FileType javascript,javascript.jsx,json,sugarss,stylus,sass,scss,css,jade,pug,html,xml,svg setlocal foldmethod=syntax

" enable concealment
set conceallevel=1

" vim-javascript conceal settings.
let g:javascript_conceal_function = 'ƒ'
let g:javascript_conceal_arrow_function = "⇒"
let g:javascript_conceal_return = '⇚'
let g:javascript_conceal_this = '@'
" let g:javascript_conceal_function = "ƒ"
" let g:javascript_conceal_null = "ø"
" let g:javascript_conceal_undefined = "¿"
" let g:javascript_conceal_NaN = "ℕ"
" let g:javascript_conceal_prototype = "¶"
" let g:javascript_conceal_static = "•"
" let g:javascript_conceal_super = "Ω"

set fillchars+=diff:┈
set diffopt=vertical                  " Use in vertical diff mode
set diffopt+=filler                   " blank lines to keep sides aligned
set diffopt+=iwhite                   " Ignore whitespace changes

" syntax highlight
filetype indent plugin on
syntax on

" hide some files by default in netrw
let g:netrw_list_hide='\..*,Gemfile.lock,README,LICENSE,node_modules'
let g:netrw_hide=0

" prevent wrapping lines
set textwidth=9999
set nowrap

" when scrolling, keep cursor this many lines away from screen border
set scrolloff=9
set sidescrolloff=9

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

" }}}
" Autocmd on save {{{
" remove trailing whitespace
autocmd FileType python,lua,json,javascript,javascript.jsx,coffee,typescript,jade,pug,html,svg,sugarss,stylus,css,scss,sass,yaml,zsh,bash autocmd BufWritePre <buffer> %s/\s\+$//e
set autoread

" }}}
" Run macro on selected lines {{{

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

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
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*.gem
set wildignore+=*.*~,*~
set wildignore+=*.swp,.lock,.DS_Store,._*,tags.lock
set isfname-==
set complete-=i                       " don't complete includes
set complete-=t                       " don't complete tags
" set completeopt-=preview              " don't open scratch preview (e.g. echodoc)
" set completeopt+=menu,menuone         " show PUM, even for one thing
set completeopt=longest,menuone,preview
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

" stop using arrows in normal mode
noremap <Up> :bNext<CR>
noremap <Down> :bnext<CR>
noremap <Left> :tabp<CR>
noremap <Right> :tabn<CR>

" }}}
" Buffer navigation {{{
map tN  :bnext<CR>
map tP  :bNext<CR>

map <C-S-Up> :bnext<CR>
map <C-S-Down> :bNext<CR>

map tL  :s<CR>

" }}}
" Tab navigation {{{
map tt :tabnew<CR>
map tcq :tabc<CR>
map tn :tabn<CR>
map tp :tabp<CR>

map tm0 :tabm0<CR>
map tmm :tabm<CR>
" }}}
" Splits navigation {{{
map <F2> :below 10sp term://$SHELL<CR>i
map <F3> :below 10sp term:///usr/bin/ranger<CR>i
map <F4> :below 10sp term:///usr/bin/node<CR>i

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
" Reading DOC files {{{
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
" AutoPairs {{{
"let g:AutoPairsMapCR=0
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
autocmd FileType json map <Leader>c :exec &g:vim_json_syntax_conceal ? "let g:vim_json_syntax_conceal=0" : "let g:vim_json_syntax_conceal=1"<CR>

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
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
            \ 'tern#Complete',
            \]
let g:deoplete#sources = {}
let g:deoplete#sources['javascript'] = ['ultisnips', 'ternjs', 'flow', 'buffer']
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" }}}
" Autocomplete-flow{{{
let g:autocomplete_flow#insert_paren_after_function = 0

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
let g:ale_set_quickfix = 1
let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_delay = 200
let g:ale_linters = {
            \ 'javascript': ['eslint', 'flow'],
            \ 'css': ['stylelint']
            \}
let g:ale_javascript_eslint_executable = '$(npm bin)/eslint'
let g:ale_javascript_flow_executable = '$(npm bin)/flow'
let g:ale_javascript_stylelint_executable = '$(npm bin)/stylelint'

nnoremap ,e :ALENextWrap<cr>
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

let g:ale_change_sign_column_color = 0
let g:ale_sign_column_always = 1
let g:ale_set_signs = 1
let g:ale_open_list = 1
let g:ale_list_window_size = 5
let g:ale_echo_cursor = 1
let g:ale_echo_msg_format = '%s [%severity%] (%linter%)'

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_style_error = '⚑'
let g:ale_sign_style_warning = '⚐'
let g:ale_sign_info = 'i'

" }}}
" Fzf {{{
nnoremap <C-p> :FZF<CR>

" }}}
" NCM {{{
" set shortmess+=c
"
" }}}
" Gist {{{
let g:gist_browser_command = 'chromium %URL%'
let g:gist_clip_command = 'xclip -selection clipboard'

" }}}

" vim:syntax=vim
