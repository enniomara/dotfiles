require("lazy").setup({
	spec = {
		{
			"nvim-neo-tree/neo-tree.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			cmd = "Neotree",
			config = function()
				require("plugins.neotree")
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			cmd = "Telescope",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-fzf-native.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
			},
			config = function()
				require("plugins.telescope")
			end,
		},
		{
			"nvim-telescope/telescope-ui-select.nvim",
			branch = "master",
		},
		{
			"rmehri01/onenord.nvim",
			branch = "main",
			config = function()
				require("onenord").setup({
					fade_nc = false, -- Fade non-current windows, making them more distinguishable
				})
			end,
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			branch = "main",
			build = "make",
		},
		{
			"akinsho/bufferline.nvim",
			version = "v3.5.0",
			dependencies = "kyazdani42/nvim-web-devicons",
			config = function()
				require("plugins.bufferline")
			end,
		},
		{
			"ntpeters/vim-better-whitespace",
			branch = "master",
			config = function()
				require("plugins.vim-better-whitespace")
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			version = "v0.5",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("plugins.gitsigns")
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			branch = "master",
			event = "BufRead",
			build = ":TsUpdate",
			config = function()
				require("plugins.treesitter")
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			branch = "master",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			event = { "BufRead" },
			config = function()
				require("treesitter-context").setup()
			end,
		},
		{
			"tpope/vim-fugitive",
			version = "v3.4",
			cmd = "Git",
		},
		{
			"tpope/vim-unimpaired",
			branch = "master",
			event = "BufRead",
		},
		{
			"tpope/vim-sleuth",
			version = "v1.2",
		},

		{
			"jose-elias-alvarez/null-ls.nvim",
			branch = "main",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"lewis6991/gitsigns.nvim",
			},
			event = { "BufRead", "BufNewFile" },
			config = function()
				require("plugins.lsp.null-ls")
			end,
		},
		{
			"neovim/nvim-lspconfig",
			branch = "master",
			event = { "VimEnter" },
		},
		{
			"williamboman/mason.nvim",
			branch = "main",
			-- after = { "nvim-lspconfig" },
			-- configuration done in mason-lspconfig.nvim
		},
		{
			"williamboman/mason-lspconfig.nvim",
			branch = "main",
			-- after = { "nvim-lspconfig", "mason.nvim", "lsp_signature.nvim" },
			config = function()
				require("plugins.lsp")
			end,
		},
		{
			"hrsh7th/nvim-cmp",
			branch = "main",
			dependencies = {
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-path",
				"windwp/nvim-autopairs",
				"onsails/lspkind-nvim",
			},
			event = { "InsertEnter", "CmdlineEnter" },
			config = function()
				require("plugins.cmp")
			end,
		},
		{
			"rafamadriz/friendly-snippets",
			branch = "main",
		},
		{
			"folke/which-key.nvim",
			version = "v1.2.0",
			config = function()
				require("which-key").setup({})
			end,
		},
		{
			"windwp/nvim-autopairs",
			branch = "master",
			config = function()
				require("nvim-autopairs").setup({
					disable_filetype = { "TelescopePrompt", "vim" },
				})
			end,
			event = { "InsertEnter" },
		},
		{
			"numToStr/Comment.nvim",
			branch = "master",
			event = "BufRead",
			config = function()
				require("Comment").setup()
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			version = "v2.20.4",
			event = "BufRead",
			config = function()
				require("indent_blankline").setup({
					space_char_blankline = " ",
					show_current_context = true,
					filetype_exclude = { "help" },
					show_trailing_blankline_indent = false,
				})
			end,
		},
		{
			"rmagatti/auto-session",
			branch = "main",
			config = function()
				require("plugins.auto-session")
			end,
		},
		{
			"hoob3rt/lualine.nvim",
			branch = "master",
			dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("lualine").setup({
					options = {
						theme = "nord",
					},
					sections = {
						lualine_x = {
							"diff",
							{
								"diagnostics",
								sources = { "nvim_diagnostic" },
								symbols = { error = " ", warn = " ", info = " ", hint = " " },
								color = {},
							},
							"encoding",
							"fileformat",
							"filetype",
						},
					},
				})
			end,
		},
		{
			"ray-x/lsp_signature.nvim",
			version = "v0.2.0",
		},
		{
			"ggandor/lightspeed.nvim",
			branch = "main",
		},
		{
			"lervag/vimtex",
			version = "v2.8",
			ft = { "tex" },
		},
		{
			"kevinhwang91/nvim-bqf",
			version = "v1.1.0",
			ft = "qf",
		},
		{
			"abecodes/tabout.nvim",
			branch = "master",
			config = function()
				require("tabout").setup({})
			end,
			-- after = { "nvim-treesitter" },
		},
		{
			"anuvyklack/pretty-fold.nvim",
			branch = "master",
			event = "BufRead",
			config = function()
				require("pretty-fold").setup({})
			end,
		},
		{
			"kylechui/nvim-surround",
			version = "v2.0.4",
			event = { "BufRead" },
			config = function()
				require("nvim-surround").setup({})
			end,
		},
		{
			"famiu/bufdelete.nvim",
			branch = "master",
			cmd = { "Bdelete", "Bwipeout" },
		},
		{
			"echasnovski/mini.ai",
			branch = "stable",
			event = "BufRead",
			config = function()
				require("mini.ai").setup()
			end,
		},
		{
			"tpope/vim-dadbod",
			opt = true,
			dependencies = {
				{
					"kristijanhusak/vim-dadbod-ui",
					branch = "master",
				},
			},
			cmd = {
				"DBUIToggle",
				"DBUI",
				"DBUIAddConnection",
				"DBUIFindBuffer",
				"DBUIRenameBuffer",
				"DBUILastQueryInfo",
			},
		},
	},
})

require("options")
require("mappings")
