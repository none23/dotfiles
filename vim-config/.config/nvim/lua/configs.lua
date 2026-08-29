vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.compatible = false

-- Indentation settings {{{
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.autoindent = true
vim.opt.copyindent = false
vim.opt.preserveindent = false
vim.opt.smartindent = false
vim.opt.cindent = false
-- }}}

-- Miscellaneous settings {{{
vim.opt.splitright = true
vim.opt.cmdheight = 1
vim.opt.hidden = true
vim.opt.updatetime = 200
vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"
vim.opt.autochdir = false
vim.opt.startofline = false
vim.opt.autoread = true
vim.opt.fileformats = { "unix", "mac", "dos" }
vim.opt.fileformat = "unix"

-- vim.opt.browsedir = "current"  -- setting seems to be removed in neovim

vim.opt.equalalways = true
vim.opt.winfixheight = true

vim.opt.laststatus = 2
vim.opt.showmode = false

vim.opt.modeline = false

vim.opt.gdefault = true

vim.opt.regexpengine = 1

vim.opt.joinspaces = false

-- Search settings
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.hlsearch = true

-- Mouse support
vim.opt.mouse = "a"

-- Optimize macro execution
vim.opt.lazyredraw = true

vim.opt.virtualedit = "block"

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 999

-- Diff mode
vim.opt.diffopt:append("vertical")
vim.opt.fillchars:append("diff:┈")
vim.opt.diffopt:append("filler")
vim.opt.diffopt:append("iwhite")

-- Syntax highlighting
vim.cmd("syntax off")

vim.opt.textwidth = 100
vim.opt.wrap = false

vim.opt.scrolloff = 9
vim.opt.sidescrolloff = 9

vim.opt.synmaxcol = 220

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.confirm = true

vim.g.ruby_host_prog = "rvm system do neovim-ruby-host"
-- }}}

-- Language-specific autocmds {{{
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "zsh", "bash", "shell", "vim", "sql" },
	command = "setlocal foldmethod=marker",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		".babelrc",
		".eslintrc",
		".huskyrc",
		".lintstagedrc",
		".prettierrc",
		".stylelintrc",
	},
	command = "setfiletype json",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"*.code-workspace",
		".coc-settings.json",
		".vscode/settings.json",
		"tsconfig.json",
	},
	command = "setfiletype jsonc",
})
-- }}}

-- Colors settings {{{
vim.opt.cursorcolumn = true
vim.opt.cursorline = true

vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.opt.termguicolors = true

vim.opt.background = "dark"

local function apply_diff_highlights()
	-- Keep diff state on the background so syntax/tree-sitter can color the text.
	vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0f3a1d" })
	vim.api.nvim_set_hl(0, "DiffChange", { bg = "#3a3216" })
	vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3a1014" })
	vim.api.nvim_set_hl(0, "DiffText", { bg = "#5a4718", bold = true })
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = apply_diff_highlights,
})

vim.cmd("colorscheme nwsome")
apply_diff_highlights()

vim.opt.colorcolumn = "100"
-- }}}

-- Completion settings {{{
vim.opt.wildmenu = true
vim.opt.wildmode = { "list:longest", "full" }
vim.opt.wildignorecase = true

vim.opt.wildignore:append({
	"*.aux",
	"*.out",
	"*.toc",
	"*.o",
	"*.obj",
	"*.exe",
	"*.dll",
	"*.jar",
	"*.pyc",
	"*.rbc",
	"*.class",
	"*.ai",
	"*.bmp",
	"*.gif",
	"*.ico",
	"*.jpg",
	"*.jpeg",
	"*.png",
	"*.psd",
	"*.webp",
	"*.avi",
	"*.m4a",
	"*.mp3",
	"*.oga",
	"*.ogg",
	"*.wav",
	"*.webm",
	"*.eot",
	"*.otf",
	"*.ttf",
	"*.woff",
	"*.docx",
	"*.zip",
	"*.tar.gz",
	"*.tar.bz2",
	"*.rar",
	"*.tar.xz",
	".sass-cache",
	"*/vendor/gems/*",
	"*/vendor/cache/*",
	"*/.bundle/*",
	"*.gem",
	"*.*~",
	"*~",
	"*.swp",
	".lock",
	".DS_Store",
	"._*",
	"tags.lock",
})

vim.opt.isfname:remove("=")
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
-- }}}

-- Storage settings {{{
vim.opt.directory = vim.fn.expand("~/.vim/dirs/tmp")

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.backupdir = vim.fn.expand("~/.vim/dirs/backups")

vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/dirs/undos")

vim.opt.viminfo:append("n~/.vim/dirs/viminfo")

local function create_dirs()
	local dirs = {
		vim.opt.backupdir._value,
		vim.opt.directory._value,
		vim.opt.undodir._value,
	}
	for _, dir in pairs(dirs) do
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end
end

create_dirs()

-- Miscellaneous mappings {{{
-- Save with sudo
vim.cmd("command! W w suda://%")

-- Save with Ctrl+S
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- Indent without losing focus
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Command mode with colon using ;
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })

-- Clear search results highlighting with Ctrl+L
vim.api.nvim_set_keymap("n", "<C-l>", ":nohlsearch<CR><C-l>", { noremap = true, silent = true })

-- Set <leader> key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Toggle concealing with <leader>c
vim.api.nvim_set_keymap("n", "<leader>c", ":lua ToggleConceal()<CR>", { noremap = true, silent = true })
function ToggleConceal()
	if vim.wo.conceallevel > 0 then
		vim.wo.conceallevel = 0
	else
		vim.wo.conceallevel = 1
	end
end

-- Sort lines with <leader>o
vim.api.nvim_set_keymap("n", "<leader>o", "vv:sort<CR>", { noremap = true, silent = true })

-- Move current line's last character to the next line with <leader>q
vim.api.nvim_set_keymap("n", "<leader>q", "$i<CR><Esc>J", { noremap = true, silent = true })

-- Run macro on selected lines
vim.api.nvim_set_keymap("x", "@", [[:<C-u>lua ExecuteMacroOverVisualRange()<CR>]], { noremap = true, silent = true })
function ExecuteMacroOverVisualRange()
	local macro = vim.fn.nr2char(vim.fn.getchar())
	vim.cmd(":'<,'>normal @" .. macro)
end

-- Stop using arrow keys in normal mode
vim.api.nvim_set_keymap("n", "<Up>", "<C-w>w", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>", "<C-w>W", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Left>", ":tabp<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", ":tabn<CR>", { noremap = true, silent = true })

-- Buffer navigation with Ctrl+Up/Down
vim.api.nvim_set_keymap("n", "<C-Up>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":bNext<CR>", { noremap = true, silent = true })

-- Tab navigation
vim.api.nvim_set_keymap("n", "tt", ":tabnew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tn", ":tabn<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tp", ":tabp<CR>", { noremap = true, silent = true })

-- Open terminal with F2
vim.api.nvim_set_keymap("n", "<F2>", ":belowright 10sp term://$SHELL<CR>i", { noremap = true, silent = true })

-- Escape key in terminal mode
vim.api.nvim_set_keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Yank to system clipboard
vim.api.nvim_set_keymap("n", "<F8>", '"+yy', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<F8>", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F7>", '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<F7>", '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F9>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<F9>", '"+p', { noremap = true, silent = true })
-- }}}

-- Concealment settings {{{
vim.opt.conceallevel = 1
vim.g.javascript_conceal_arrow_function = "⇒"

-- }}}

-- Close loclist window when empty
vim.api.nvim_create_augroup("CloseLoclistWindowGroup", { clear = true })
vim.api.nvim_create_autocmd("QuitPre", {
	group = "CloseLoclistWindowGroup",
	pattern = "*",
	command = "if empty(&buftype) | lclose | endif",
})
