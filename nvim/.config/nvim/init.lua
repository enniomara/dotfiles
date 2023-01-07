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
		commit = "a1bd6866b539afdaa25305626c7aa6049b805d67",
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
		commit = "b05d57d04445836e6b9235e1937bf0a3ba42506b",
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
		tag = "v3.1.0",
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
		commit = "6c9f3d03e50f9d218d913e4ad1c812054a0ba61b",
		event = "BufRead",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-context",
		branch = "master",
		commit = "cacee4828152dd3a83736169ae61bbcd29a3d213",
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
		commit = "18497120fa0db0a3b9e53870ac8f342be4bffb57",
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
		commit = "85cd2ecacd8805614efe3fb3a5146ac7d0f88a17",
		event = { "VimEnter" },
	})
	use({
		"williamboman/mason.nvim",
		branch = "main",
		commit = "beb79ced9e49ea1ce2bd170b79e0cf819a8377c7",
		after = { "nvim-lspconfig" },
		-- configuration done in mason-lspconfig.nvim
	})
	use({
		"williamboman/mason-lspconfig.nvim",
		branch = "main",
		commit = "d7ff61a828d59bc593ea3e2020508c114048d790",
		after = { "nvim-lspconfig", "mason.nvim", "lsp_signature.nvim" },
		config = function()
			require("plugins.lsp")
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		branch = "main",
		commit = "11a95792a5be0f5a40bab5fc5b670e5b1399a939",
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
		commit = "046e4d3491baf664e0eef5231d28beb49333578b",
	})
	use({
		"folke/which-key.nvim",
		branch = "main",
		commit = "8682d3003595017cd8ffb4c860a07576647cc6f8",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"windwp/nvim-autopairs",
		branch = "master",
		commit = "03580d758231956d33c8dd91e2be195106a79fa4",
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
		commit = "eab2c83a0207369900e92783f56990808082eac2",
		event = "BufRead",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.20.2",
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
		commit = "c8b2f4048f846387361bd04cc185bf1aa7d2e3d1",
		config = function()
			require("plugins.auto-session")
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		branch = "master",
		commit = "0050b308552e45f7128f399886c86afefc3eb988",
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
		tag = "v1.0.0",
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
		commit = "e6298736a7835bcb365dd45a8e8bfe86d935c1f8",
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
		branch = "main",
		tag = "v1.0.0",
		event = { "BufRead" },
		config = function()
			require("nvim-surround").setup({})
		end,
	})
	use({
		"famiu/bufdelete.nvim",
		branch = "master",
		commit = "f79e9d186b42fba5f1b1362006e7c70240db97a4",
		cmd = { "Bdelete", "Bwipeout" },
	})
	use({
		"echasnovski/mini.ai",
		branch = "stable",
		commit = "14a1382372195573c6c7f494ab8bb298b03e6f04",
		event = "BufRead",
		config = function()
			require("mini.ai").setup()
		end,
	})
end)

require("impatient")
require("options")
require("mappings")

