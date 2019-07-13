" Plug {{{
scriptencoding utf-8
set encoding=utf-8

" install if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

set nocompatible
call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/tabman.vim'
Plug 'mileszs/ack.vim'
Plug 'lambdalisue/suda.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/IndexedSearch'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'ap/vim-css-color'
Plug 'alampros/vim-styled-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'wakatime/vim-wakatime'
Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" easy plugin updates
command! PU PlugUpdate | PlugUpgrade

" }}}

" indentation {{{
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

" misc-settings {{{
set splitright
set cmdheight=3
set hidden
set updatetime=200
set shortmess+=c
set signcolumn=yes
set noautochdir
set nostartofline
set autoread
set fileformats=unix,mac,dos
set fileformat=unix

" browse files in same dir as open file
set browsedir=buffer

" keep splits equal width (but not height)
set equalalways
set winfixheight

" status bar
set laststatus=2
set noshowmode

" disable modeline (i.e. 'vim:option=value' comments at the end of files
set nomodeline

" substitute with '/g' by default
set gdefault

" no excessive whitespace wthen joining lines
set nojoinspaces

" search
set incsearch
set ignorecase
set smartcase
set infercase
set hlsearch

" mouse support
set mouse=a

" don't redraw screen durring macros
set lazyredraw

" cursor can move to spaces with no real character in vblock mode.
set virtualedit=block

" folding
set foldmethod=syntax
set foldlevel=999

" diff-mode
set diffopt=vertical
set fillchars+=diff:┈

" add blank lines to keep sides aligned
set diffopt+=filler

" ignore whitespace changes
set diffopt+=iwhite

" syntax highlight
filetype indent plugin on
syntax on


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


" }}}

" language-specific-autocmd {{{
" remove trailing whitespace on save
autocmd BufRead * autocmd  BufWritePre <buffer> %s/\s\+$//e

" use foldmethod=marker
autocmd FileType zsh,bash,shell,vim
      \ setlocal foldmethod=marker

" syntax highlighting in .flow files
autocmd BufRead *.{js,jsx,mjs,jsm,es,es6,flow}
      \ setfiletype javascript

" consider .babelrc, .prettierrc, .eslintrc, etc. to be jsonc
autocmd BufRead {.babelrc,.prettierrc,.eslintrc,.stylelintrc,tsconfig.json}
      \ setfiletype jsonc

" }}}

" colors {{{
set cursorcolumn
set cursorline

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set termguicolors

set background=dark

colorscheme nwsome

" highlight 100'th column
set colorcolumn=100

" }}}
"
" completion  {{{
set wildmenu
set wildmode=list:longest,full
set wildignorecase

" ignore these files for completion
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
set completeopt=menuone,noinsert,noselect

" }}}

" storage {{{
set directory=~/.vim/dirs/tmp

" turn off backups
set nobackup
set nowritebackup
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

" misc-mappings {{{
" save with sudo
ca w!! w suda://%


" save with C-s
nnoremap <c-s> :w<cr>

" indent without loosing focus
vnoremap < <gv
vnoremap > >gv

" command with colon
noremap ; :

"clear search results highlighting
nnoremap <c-l> :nohl<cr><c-l>

" set <leader> key
let mapleader = " "

" toggle concealing
map <leader>c :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<cr>

" sort lines
map <leader>o vv:sort<cr>

" move curent line's last character to the next line
map <leader>q $i<cr><esc>J

" escape key in terminal
:tnoremap <esc><esc> <c-\><c-n>

" run macro on selected lines
xnoremap @ :<c-u>call ExecuteMacroOverVisualRange()<cr>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction


" stop using arrows in normal mode
noremap <up> <c-w>w
noremap <down> <c-w>W
noremap <left> :tabp<cr>
noremap <right> :tabn<cr>

" buffer navigation
map <c-up> :bnext<cr>
map <c-down> :bNext<cr>

" tab navigation
map tt :tabnew<cr>
map tn :tabn<cr>
map tp :tabp<cr>

" term-mode
map <F2> :below 10sp term://$SHELL<cr>i
" map <F4> :below 10sp term:///usr/bin/node<cr>i

" yank to system clipboard
nmap <F8> "+yy
vmap <F8> "+y
nmap <F7> "+P
vmap <F7> "+P
nmap <F9> "+p
vmap <F9> "+p

" }}}

" concealment {{{
set conceallevel=1
let g:javascript_conceal_arrow_function = '⇒'
" let g:javascript_conceal_function = 'ƒ'
" let g:javascript_conceal_return = '⇚'
" let g:javascript_conceal_this = '@'
" let g:javascript_conceal_null = 'ø'
" let g:javascript_conceal_undefined = '¿'
" let g:javascript_conceal_NaN = 'ℕ'
" let g:javascript_conceal_prototype = '¶'
" let g:javascript_conceal_static = '•'
" let g:javascript_conceal_super = 'Ω'

" }}}
"
" easy-motion {{{
map <leader> <plug>(easymotion-prefix)

map <leader>l <plug>(easymotion-lineforward)
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
map <leader>h <plug>(easymotion-linebackward))

" }}}

" expand-region {{{
vmap v <plug>(expand_region_expand)
vmap <c-v> <plug>(expand_region_shrink)

" }}}

" tab-man {{{
" toggle display
let g:tabman_toggle = 'tl'

" focus on display
let g:tabman_focus  = 'tf'

" }}}

" airline {{{
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

" tab numbers
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" coc diagnostics
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" }}}

" easy-align {{{
let g:easy_align_interactive_modes = ['l', 'r']
let g:easy_align_bang_interactive_modes = ['c', 'r']
xmap ga <plug>(EasyAlign)
nmap ga <plug>(EasyAlign)

" }}}

" emmet {{{
let g:user_emmet_settings = {
      \ 'javascript.jsx': { 'extends': 'jsx', 'attribute_name': { 'for': 'htmlFor', 'class': 'className' }, 'quote_char': '"' },
      \ 'typescript.tsx': { 'extends': 'jsx', 'attribute_name': { 'for': 'htmlFor', 'class': 'className' }, 'quote_char': '"' },
      \ }

autocmd FileType javascript.jsx,typescript.tsx EmmetInstall

" }}}

" ultisnips {{{
let g:UltiSnipsExpandTrigger="<c-j>"

" }}}

" ale {{{
" let g:ale_set_baloons = 1
let g:ale_set_quickfix = 1
" let g:ale_set_loclist = 1
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 6
let g:ale_completion_enabled = 0
" let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_delay = 100
let g:ale_fix_on_save = 1

let g:ale_linters = {}
let g:ale_linters['javascript'] = ['flow', 'eslint']
let g:ale_linters['typescript'] = ['tsserver', 'eslint']
let g:ale_linters['css'] = ['css-languageserver', 'stylelint']
let g:ale_linters['scss'] = ['css-languageserver', 'stylelint']

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier', 'eslint']
let g:ale_fixers['typescript'] = ['prettier', 'eslint']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['jsonc'] = ['prettier']
let g:ale_fixers['json5'] = ['prettier']
let g:ale_fixers['css'] = ['prettier', 'stylelint']
let g:ale_fixers['scss'] = ['prettier', 'stylelint']
let g:ale_fixers['graphql'] = ['prettier']
let g:ale_fixers['markdown'] = ['prettier']

let g:ale_javascript_eslint_suppress_missing_config = 1
let g:ale_javascript_eslint_suppress_eslintignore = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_typescript_tsserver_use_global = 0

nnoremap ,e :ALENextWrap<cr>
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

let g:ale_change_sign_column_color = 0
let g:ale_sign_column_always = 1
let g:ale_set_signs = 1
let g:ale_open_list = 1
let g:ale_echo_cursor = 1
" let g:ale_cursor_detail = 1
let g:ale_echo_msg_format = '%s (%linter%) %[code]%'
let g:ale_echo_msg_error_str = '🔥'
let g:ale_echo_msg_warning_str = '💩'
let g:ale_echo_msg_info_str = '👉'
let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '💩'
let g:ale_sign_style_error = '💩'
let g:ale_sign_style_warning = '💩'
let g:ale_sign_info = '👉'
let g:ale_virtualtext_cursor = 0
let g:ale_virtualtext_prefix = ''

nnoremap ,e :ALENextWrap<cr>
nnoremap ,d :ALEFindReferences<cr>
nnoremap ,i :ALEDetail<cr>
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" }}}

" fzf {{{
nnoremap <c-p> :FZF<cr>

" }}}

" ack {{{
cnoreabbrev Ack Ack!
nnoremap <leader>a :Ack!<space>

" }}}

" git-fugitive {{{
set statusline+=%{fugitive#statusline()}

autocmd QuickFixCmdPost *grep* cwindow

" }}}


" nerd-tree {{{
let NERDTreeShowHidden=1
nmap <F5> :NERDTreeToggle<cr>

" }}}

" (off?) lsp-servers {{{
let g:lsp_insert_text_enabled = 1
let g:lsp_virtual_text_enabled = 0

au User lsp_setup call lsp#register_server({
  \ 'name': 'graphql-languge-server',
  \ 'cmd': {server_info->['graphql-languge-server', 'server']},
  \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.graphqlconfig'))},
  \ 'whitelist': ['javascript', 'javascript.jsx'],
  \ })

au User lsp_setup call lsp#register_server({
  \ 'name': 'flow',
  \ 'cmd': {server_info->['flow', 'lsp']},
  \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
  \ 'whitelist': ['javascript', 'javascript.jsx'],
  \ })

au User lsp_setup call lsp#register_server({
    \ 'name': 'css-languageserver',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
    \ 'whitelist': ['css', 'less', 'scss', 'sass'],
    \ })


" }}}

" coc {{{
" trigger completion and navigate with <tab>
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : <SID>check_back_space() ? "\<tab>" : coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

" trigger completion with <c-space>
inoremap <silent><expr> <c-space> coc#refresh()

" confirm completion with <cr>
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

" navigate diagnostics
nmap <silent> [c <plug>(coc-diagnostic-prev)
nmap <silent> ]c <plug>(coc-diagnostic-next)

" gotos
nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

" show documentation in preview window
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<cr>

" highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" rename word
nmap <leader>rw <plug>(coc-rename)

" format selected region
vmap <leader>f  <plug>(coc-format-selected)
nmap <leader>f  <plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,jsonc setlocal formatexpr=CocAction('formatSelected')

  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" codeAction on selected region (e.g. `<leader>aap` for current paragraph)
vmap <leader>a  <plug>(coc-codeaction-selected)
nmap <leader>a  <plug>(coc-codeaction-selected)

" codeAction on the current line
nmap <leader>ac  <plug>(coc-codeaction)

" autofix problem
nmap <leader>F  <plug>(coc-fix-current)

" format buffer
command! -nargs=0 Format :call CocAction('format')

" fold buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" add diagnostic info for Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" CocList {{{
" show all diagnostics
nnoremap <silent> <space>A  :<c-u>CocList diagnostics<cr>

" manage extensions
nnoremap <silent> <space>e  :<c-u>CocList extensions<cr>

" show commands
nnoremap <silent> <space>c  :<c-u>CocList commands<cr>

" find symbol of current document
nnoremap <silent> <space>o  :<c-u>CocList outline<cr>

" search workspace symbols
nnoremap <silent> <space>s  :<c-u>CocList -I symbols<cr>

" do default action for next item.
nnoremap <silent> <space>j  :<c-u>CocNext<cr>

" do default action for previous item.
nnoremap <silent> <space>k  :<c-u>CocPrev<cr>

" resume latest coc list
nnoremap <silent> <space>p  :<c-u>CocListResume<cr>

" }}}

" CocJest {{{
" run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

" run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

" run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<cr>

" init jest in current cwd, (requires global jest command)
command! JestInit :call CocAction('runCommand', 'jest.init')

" }}}

" }}}

" vim:syntax=vim
