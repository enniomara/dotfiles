require("packer").startup(function(use)
	-- Packer can manage itself
	use({
		"lewis6991/impatient.nvim",
		branch = "main",
		commit = "c90e273f7b8c50a02f956c24ce4804a47f18162e",
	})
	use({
		"nvim-neo-tree/neo-tree.nvim",
		tag = "2.48",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		config = function()
			require("plugins.neotree")
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		commit = "766a45a972408f67e793a3b63e3c419ff5458753",
		cmd = "Telescope",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	})
	use({
		"nvim-telescope/telescope-ui-select.nvim",
		branch = "master",
		commit = "62ea5e58c7bbe191297b983a9e7e89420f581369",
	})
	use({
		"rmehri01/onenord.nvim",
		branch = "main",
		commit = "71bdcdf105a8feb16cd5248b40e44c88832f75ca",
		config = function()
			require("onenord").setup({
				fade_nc = false, -- Fade non-current windows, making them more distinguishable
			})
		end,
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		branch = "main",
		commit = "fab3e2212e206f4f8b3bbaa656e129443c9b802e",
		run = "make",
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.5.0",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
	})
	use({
		"ntpeters/vim-better-whitespace",
		branch = "master",
		commit = "1b22dc57a2751c7afbc6025a7da39b7c22db635d",
		config = function()
			require("plugins.vim-better-whitespace")
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		tag = "v0.5",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.gitsigns")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		commit = "94f9a569736fea4c4128216800612a733e59b083",
		event = "BufRead",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-context",
		branch = "master",
		commit = "895ec44f5c89bc67ba5440aef3d1f2efa3d59a41",
		requires = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufRead" },
		config = function()
			require("treesitter-context").setup()
		end,
	})
	use({
		"tpope/vim-fugitive",
		tag = "v3.4",
		cmd = "Git",
	})
	use({
		"tpope/vim-unimpaired",
		branch = "master",
		commit = "6d44a6dc2ec34607c41ec78acf81657248580bf1",
		event = "BufRead",
	})
	use({
		"tpope/vim-sleuth",
		tag = "v1.2",
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		branch = "main",
		commit = "900c38cfa91eb7ff2716da70f2f2c1d33741cf0a",
		requires = {
			"nvim-lua/plenary.nvim",
			"lewis6991/gitsigns.nvim",
		},
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("plugins.lsp.null-ls")
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		branch = "master",
		commit = "1a2d5f5224c65b0709bf5da0ccd9cad29272083a",
		event = { "VimEnter" },
	})
	use({
		"williamboman/mason.nvim",
		branch = "main",
		commit = "add6d1d63d8b86af951ba64b4157fe6b0af173d4",
		after = { "nvim-lspconfig" },
		-- configuration done in mason-lspconfig.nvim
	})
	use({
		"williamboman/mason-lspconfig.nvim",
		branch = "main",
		commit = "7a97a77eee486ae152d2c559a459eda7c8aa12aa",
		after = { "nvim-lspconfig", "mason.nvim", "lsp_signature.nvim" },
		config = function()
			require("plugins.lsp")
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		branch = "main",
		commit = "feed47fd1da7a1bad2c7dca456ea19c8a5a9823a",
		requires = {
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
	})
	use({
		"rafamadriz/friendly-snippets",
		branch = "main",
		commit = "6fa50a94ba5378bb73013a6e163376d8e69bd8a5",
	})
	use({
		"folke/which-key.nvim",
		branch = "main",
		tag = "v1.1.1",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"windwp/nvim-autopairs",
		branch = "master",
		commit = "ab49517cfd1765b3f3de52c1f0fda6190b44e27b",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
		event = { "InsertEnter" },
	})
	use({
		"numToStr/Comment.nvim",
		branch = "master",
		commit = "6821b3ae27a57f1f3cf8ed030e4a55d70d0c4e43",
		event = "BufRead",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.20.4",
		event = "BufRead",
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
				filetype_exclude = { "help" },
				show_trailing_blankline_indent = false,
			})
		end,
	})
	use({
		"rmagatti/auto-session",
		branch = "main",
		commit = "04ccdac802200ecc363b251cf922b2b022bb515c",
		config = function()
			require("plugins.auto-session")
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		branch = "master",
		commit = "e99d733e0213ceb8f548ae6551b04ae32e590c80",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
	})
	use({
		"ray-x/lsp_signature.nvim",
		tag = "v0.2.0",
	})
	use({
		"ggandor/lightspeed.nvim",
		branch = "main",
		commit = "299eefa6a9e2d881f1194587c573dad619fdb96f",
	})
	use({
		"lervag/vimtex",
		tag = "v2.8",
		ft = { "tex" },
	})
	use({
		"kevinhwang91/nvim-bqf",
		tag = "v1.1.0",
		ft = "qf",
	})
	use({
		"abecodes/tabout.nvim",
		branch = "master",
		commit = "c37ce26f316a2df693140450b8def41e89c0f57e",
		config = function()
			require("tabout").setup({})
		end,
		after = { "nvim-treesitter" },
	})
	use({
		"ojroques/vim-oscyank",
		branch = "main",
		commit = "ffe827a27dae98aa826e2295336c650c9a434da0",
		event = "BufRead",
	})
	use({
		"anuvyklack/pretty-fold.nvim",
		branch = "master",
		commit = "a7d8b424abe0eedf50116c460fbe6dfd5783b1d5",
		event = "BufRead",
		config = function()
			require("pretty-fold").setup({})
		end,
	})
	use({
		"kylechui/nvim-surround",
		tag = "v1.0.0",
		event = { "BufRead" },
		config = function()
			require("nvim-surround").setup({})
		end,
	})
	use({
		"famiu/bufdelete.nvim",
		branch = "master",
		commit = "8933abc09df6c381d47dc271b1ee5d266541448e",
		cmd = { "Bdelete", "Bwipeout" },
	})
	use({
		"echasnovski/mini.ai",
		branch = "stable",
		commit = "efeab91f9373d6d3c73314fda9e3366020d05157",
		event = "BufRead",
		config = function()
			require("mini.ai").setup()
		end,
	})
end)

require("impatient")
require("options")
require("mappings")

