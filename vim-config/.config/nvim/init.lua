require("configs")

local baml_command = vim.fn.exepath("baml")
if baml_command == "" then
	baml_command = vim.fn.exepath("baml-cli")
end

local coc_user_config = vim.g.coc_user_config or {}
coc_user_config["languageserver.baml.enable"] = baml_command ~= ""
if baml_command ~= "" then
	coc_user_config["languageserver.baml.command"] = baml_command
end
vim.g.coc_user_config = coc_user_config

-- Install lazy.nvim if not already installed
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{ "kien/tabman.vim" },
	{ "lambdalisue/suda.vim" },
	{ "tpope/vim-surround" },
	{ "terryma/vim-expand-region" },
	{ "vim-scripts/IndexedSearch" },
	{ "junegunn/vim-easy-align" },
	{ "airblade/vim-gitgutter" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		opts = {
			window = {
				mappings = {
					["Y"] = "none",
				},
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_by_name = {
						".git",
						".next",
						".DS_Store",
					},
					always_show = {
						".env",
					},
				},
			},
		},
	},

	{ "ap/vim-css-color" },
	{ "stevearc/conform.nvim", opts = {} },
	{ "neoclide/coc.nvim", build = "yarn install --frozen-lockfile" },
	{ "mattn/emmet-vim" },
	{ "tpope/vim-apathy" },
	{ "tpope/vim-fugitive" },
	{ "jreybert/vimagit" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "nvim-treesitter/nvim-treesitter", branch = "main", lazy = false, build = ":TSUpdate" },
	-- { "github/copilot.vim", branch = "release" },
	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	-- 	config = function()
	-- 		require("supermaven-nvim").setup({})
	-- 	end,
	-- },

	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
})

-- Easy plugin updates
vim.api.nvim_create_user_command("PU", function()
	require("lazy").update()
end, {})

vim.keymap.set("n", "<leader>lw", "<cmd>LW<CR>", { noremap = true, silent = true, desc = "Local Whisper" })

-- Expand Region
vim.api.nvim_set_keymap("v", "v", "<Plug>(expand_region_expand)", {})
vim.api.nvim_set_keymap("v", "<C-v>", "<Plug>(expand_region_shrink)", {})

-- GitGutter
vim.api.nvim_set_keymap("n", "<Leader>gn", "<Plug>(GitGutterNextHunk)", {})
vim.api.nvim_set_keymap("n", "<Leader>gp", "<Plug>(GitGutterPrevHunk)", {})
vim.keymap.set("n", "<Leader>ga", function()
	if vim.wo.diff then
		vim.cmd.normal({ args = { "dp" }, bang = true })
		return
	end

	local keys = vim.api.nvim_replace_termcodes("<Plug>(GitGutterStageHunk)", true, false, true)
	vim.api.nvim_feedkeys(keys, "m", false)
end, { silent = true, desc = "Stage hunk" })
vim.api.nvim_set_keymap("n", "<Leader>gu", "<Plug>(GitGutterUndoHunk)", {})

-- Vimagit
vim.g.magit_default_fold_level = 0
vim.api.nvim_set_keymap("n", "<leader>gs", ":Magit<CR>", { noremap = true })
vim.keymap.set("n", "<leader>lg", function()
	vim.cmd("Gvdiffsplit")
	vim.schedule(function()
		vim.cmd.wincmd("l")
	end)
end, { noremap = true, silent = true, desc = "Open Fugitive diff and focus right pane" })

-- Tabman
vim.g.tabman_toggle = "tl"
vim.g.tabman_focus = "tf"

-- Easy Align
vim.g.easy_align_interactive_modes = { "l", "r" }
vim.g.easy_align_bang_interactive_modes = { "c", "r" }
vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})

-- Emmet
vim.g.user_emmet_settings = {
	["javascript.jsx"] = {
		extends = "jsx",
		attribute_name = { ["for"] = "htmlFor", ["class"] = "className" },
		quote_char = '"',
	},
	["javascriptreact"] = {
		extends = "jsx",
		attribute_name = { ["for"] = "htmlFor", ["class"] = "className" },
		quote_char = '"',
	},
	["typescriptreact"] = {
		extends = "jsx",
		attribute_name = { ["for"] = "htmlFor", ["class"] = "className" },
		quote_char = '"',
	},
	["typescript.tsx"] = {
		extends = "jsx",
		attribute_name = { ["for"] = "htmlFor", ["class"] = "className" },
		quote_char = '"',
	},
}
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript.jsx", "typescript.tsx" },
	command = "EmmetInstall",
})

-- FZF / Telescope
vim.api.nvim_set_keymap("n", "<C-p>", '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<CR>', { noremap = true })

-- Neotree
vim.keymap.set("n", "<F5>", function()
	if vim.bo.filetype == "neo-tree" then
		vim.cmd("Neotree close")
	else
		vim.cmd("Neotree filesystem reveal left")
	end
end, { noremap = true, desc = "Toggle Neotree" })

-- Treesitter Configuration
vim.filetype.add({
	extension = {
		baml = "baml",
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").baml = {
			install_info = {
				url = "https://github.com/BoundaryML/baml-treesitter",
				revision = "276b4d8471f1c2f2ce80f182ab46d171b825f2b7",
				queries = "queries",
			},
		}
	end,
})

local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
require("nvim-treesitter").setup({
	install_dir = parser_install_dir,
})
require("nvim-treesitter").install({
	"bash",
	"baml",
	"cpp",
	"css",
	"dockerfile",
	"go",
	"html",
	"java",
	"javascript",
	"json",
	"kotlin",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"toml",
	"tsx",
	"typescript",
	"xml",
	"yaml",
})

vim.treesitter.language.register("bash", "zsh")
vim.treesitter.language.register("json", "jsonc")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

-- https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.lua

-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", ",e", "<Plug>(coc-diagnostic-next)", { silent = true })
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Use K to show documentation in preview window
function _G.show_docs()
	local cw = vim.fn.expand("<cword>")
	if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
		vim.api.nvim_command("h " .. cw)
	elseif vim.api.nvim_eval("coc#rpc#ready()") then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end
keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
	group = "CocGroup",
	command = "silent call CocActionAsync('highlight')",
	desc = "Highlight symbol under cursor on CursorHold",
})

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
	group = "CocGroup",
	pattern = "typescript,json",
	command = "setl formatexpr=CocAction('formatSelected')",
	desc = "Setup formatexpr specified filetype(s).",
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
	group = "CocGroup",
	pattern = "CocJumpPlaceholder",
	command = "call CocActionAsync('showSignatureHelp')",
	desc = "Update signature help on jump placeholder",
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true }
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true, expr = true }
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true }
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = {
			-- 'encoding',
			-- 'fileformat',
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

-- require("supermaven-nvim").setup({
-- 	keymaps = {
-- 		accept_suggestion = "<Tab>",
-- 	},
-- })

require("conform").setup({
	formatters = {
		prettier = {
			-- cwd means "config working directory"
			require_cwd = true,

			cwd = require("conform.util").root_file({
				".prettierrc",
				".prettierrc.json",
				".prettierrc.yml",
				".prettierrc.yaml",
				".prettierrc.json5",
				".prettierrc.js",
				".prettierrc.cjs",
				".prettierrc.mjs",
				".prettierrc.toml",
				"prettier.config.js",
				"prettier.config.cjs",
				"prettier.config.mjs",
			}),
		},
	},

	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettier", "eslint" },
		css = { "prettier", "stylelint" },
		scss = { "prettier", "stylelint" },
		graphql = { "prettier" },
		markdown = { "prettier" },
		typescript = { "prettier", "eslint" },
		typescriptreact = { "prettier", "eslint" },
		json = { "prettier" },
		jsonc = { "prettier" },
		json5 = { "prettier" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
