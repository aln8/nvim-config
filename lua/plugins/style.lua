return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			---@diagnostic disable-next-line missing-fields
			treesitter.setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				autotag = {
					enable = true,
				},
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"css",
					"cpp",
					"go",
					"gomod",
					"python",
					"toml",
					"markdown",
					"markdown_inline",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"c",
					"rust",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				rainbow = {
					enable = true,
					disable = { "html" },
					extended_mode = false,
					max_file_lines = nil,
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({})
		end,
	},
	{
		"folke/trouble.nvim",
		lazy = true,
		cmd = { "TroubleToggle", "Trouble", "TroubleRefresh" },
		config = function()
			require("trouble").setup()
		end,
	},

	-- themes
	{
		"ray-x/aurora",
		init = function()
			vim.g.aurora_italic = 1
			vim.g.aurora_transparent = 1
			vim.g.aurora_bold = 1
		end,
		config = function()
			vim.cmd.colorscheme("aurora")
			-- override defaults
			vim.api.nvim_set_hl(0, "@number", { fg = "#e933e3" })
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		-- init = function()
		-- if vim.fn.argc(-1) == 1 then
		-- 	local stat = vim.loop.fs_stat(vim.fn.argv(0))
		-- 	if stat and stat.type == "directory" then
		-- 		require("neo-tree").setup({
		-- 			filesystem = {
		-- 				hijack_netrw_behavior = "open_current",
		-- 			},
		-- 		})
		-- 	end
		-- end
		-- end,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({})

			-- set keymaps
			local keymap = vim.keymap

			keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
			keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
			keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
			keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Find string under cursor in cwd" })
			keymap.set("n", "<leader>fc", "<cmd>Telescope git commits<cr>", { desc = "Find todos" })
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 10,
				open_mapping = [[<c-\>]],
				shading_factor = 2,
				-- direction = "float",
				float_opts = {
					border = "curved",
				},
			})
		end,
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		keys = {
			-- Will use Telescope if installed or a vim.ui.select picker otherwise
			{ "<leader>wr", "<cmd>SessionSearch<CR>", desc = "Session search" },
			{ "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
			{ "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
		},

		---enables autocomplete for opts
		---@module "auto-session"
		opts = {
			-- ⚠️ This will only work if Telescope.nvim is installed
			-- The following are already the default values, no need to provide them if these are already the settings you want.
			session_lens = {
				-- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
				load_on_setup = true,
				previewer = false,
				mappings = {
					-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
					delete_session = { "i", "<C-D>" },
					alternate_session = { "i", "<C-S>" },
					copy_session = { "i", "<C-Y>" },
				},
				-- Can also set some Telescope picker options
				-- For all options, see: https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
				theme_conf = {
					border = true,
					-- layout_config = {
					--   width = 0.8, -- Can set width and height as percent of window
					--   height = 0.5,
					-- },
				},
			},
		},
	},
}
