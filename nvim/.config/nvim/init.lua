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
		commit = "9de317bdea2bc393074651179c4fc7f93e9b2d56",
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
		commit = "9a59d47db81e566d4e254904479f129cfffe5f21",
		config = function()
			require("onenord").setup({
				fade_nc = false, -- Fade non-current windows, making them more distinguishable
			})
		end,
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		branch = "main",
		commit = "580b6c48651cabb63455e97d7e131ed557b8c7e2",
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
		commit = "2083a34dc6b70b8d87391419fd197830fc26c9a4",
		event = "BufRead",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-context",
		branch = "master",
		commit = "8cd25630a4cd69f4baab32086e96b979c50b56e4",
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
		commit = "f8ffcd7cb8fb3325c711d459152ef132b5b65aed",
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
		commit = "844e1c5b27cf4b3987587b3311a9ea4912c6d8d8",
		event = { "VimEnter" },
	})
	use({
		"williamboman/mason.nvim",
		branch = "main",
		commit = "3fb2be48864b7850a26c54c04cedb54e95dcdf3f",
		after = { "nvim-lspconfig" },
		-- configuration done in mason-lspconfig.nvim
	})
	use({
		"williamboman/mason-lspconfig.nvim",
		branch = "main",
		commit = "b64fdede85fd5e0b720ce722919e0a9b95ed6547",
		after = { "nvim-lspconfig", "mason.nvim", "lsp_signature.nvim" },
		config = function()
			require("plugins.lsp")
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		branch = "main",
		commit = "777450fd0ae289463a14481673e26246b5e38bf2",
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
		commit = "9590ff90759488674cf97fe5d5754a0733ab37bb",
	})
	use({
		"folke/which-key.nvim",
		tag = "v1.2.0",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"windwp/nvim-autopairs",
		branch = "master",
		commit = "7470af886ffb3df32800e5ef9c072a6cd825770d",
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
		commit = "a89339ffbee677ab0521a483b6dac7e2e67c907e",
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
		commit = "f391aba10ee61927a1cceb9ea3a9dde501e87e9e",
		config = function()
			require("plugins.auto-session")
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		branch = "master",
		commit = "84ffb80e452d95e2c46fa29a98ea11a240f7843e",
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
		commit = "0d275c8d25f32457e67b5c66d6ae43f26a61bce5",
		config = function()
			require("tabout").setup({})
		end,
		after = { "nvim-treesitter" },
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
		tag = "v2.0.4",
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
		commit = "fdb8dd34c326040f99b178536eeaee41d1efe643",
		event = "BufRead",
		config = function()
			require("mini.ai").setup()
		end,
	})
end)

require("impatient")
require("options")
require("mappings")

