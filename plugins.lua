return {
	{
		---Plugins to Consider
		-- treesitter-context, nvim-bqf, treesj, trouble

	},
	{
		"akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
		event = "VeryLazy",
		config = function (_,opts)
			--load init options for the plugin
			require("toggleterm").setup(opts)
			--make alterations
			require("toggleterm").setup({
				autochdir = true,
			})
		end
	},
	{
		'neovim-session-manager',
		enabled = false
	},
	{
		"max397574/better-escape.nvim",
		enabled = false

	},
	{
		'LukasPietzschmann/telescope-tabs',
		event = "VeryLazy",
	},
	{
		'christoomey/vim-tmux-navigator',
		event = "VeryLazy"
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		config = function()
			require("marks").setup({
				default_mappings = true,
				builtin_marks = { ".", "<", ">", "^", "z", "y", "x" },
				cyclic = true,
				refresh_interval = 250,
				sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
				excluded_filetypes = {
					"neo-tree",
					"nui",
				},
				bookmark_0 = {
					sign = "⚑",
					virt_text = "BookMark",
				},
				mappings = {},
			})
		end
	},
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy"
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {}
	},
	{
		"phaazon/hop.nvim",
		branch = 'v2', -- optional but strongly recommended
		event = "VeryLazy",
		cmd = { "HopChar1", "HopLine" },
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	},
	{

	},
	{
		"p00f/clangd_extensions.nvim",
		after = "mason-lspconfig.nvim",
		config = function()
			require("clangd_extensions").setup {
				server = astronvim.lsp.server_settings "clangd"
			}
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		after = "mason-lspconfig.nvim",
		config = function()
			require("rust-tools").setup({
				-- server = astronvim.lsp.server_settings "rust_analyzer",
				opts = {
					tools = {
						inlay_hints = {
							auto = false,
							only_current_line = false,
							show_parameter_hints = true,
							RustSetInlayHints = true,
							RustEnableInlayHints = true,
							parameter_hint_prefix = ": ",
							other_hints_prefix = "--> "
						},
					},
				},
			})
		end,
	},
	{
		"jose-elias-alvarez/typescript.nvim",
		after = "mason-lspconfig.nvim",
		config = function()
			require("typescript").setup {
				server = astronvim.lsp.server_settings "tsserver"
			}
		end,
	},
	{
		"catppuccin/nvim",
		as = "catppuccin",
		colorscheme = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup {
				flavour = "mocha"
			}
		end
	}, -- install catppuccin
	-- {
	--   "folke/tokyonight.nvim",
	--   as = "tokyonight",
	--   lazy = false,
	--   priority = 1000,
	--   config = function()
	--     require("tokyonight").setup {
	--       style = "night",
	--       on_colors = function(colors)
	--         colors.hint = colors.orange
	--         colors.git.add = "#58F139"
	--         colors.gitSigns.add = "#58F139"
	--         colors.git.change = colors.orange
	--         colors.gitSigns.change = colors.orange
	--       end
	--     }
	--   end
	-- }, --install tokyonight
}
