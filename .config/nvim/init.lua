local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

vim.cmd([[packadd packer.nvim]])

require("packer").startup(function(use)
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim", lock = true })
	use({
		"kyazdani42/nvim-tree.lua",
		tag = "1.6.7",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.nvim-tree")
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		branch = "master",
		commit = "99aa102b384305311308ff573b6790fa53366e10",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	})
	use({
		"rmehri01/onenord.nvim",
		branch = "main",
		commit = "9d437b69afac269e0a24a94c9bf9ce5328730fed",
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		branch = "main",
		commit = "b8662b076175e75e6497c59f3e2799b879d7b954",
		run = "make",
	})
	use({
		"akinsho/bufferline.nvim",
		branch = "master",
		commit = "de66766716ab29414c7dd078d16b4773ab53a0bd",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
	})
	use({
		"ntpeters/vim-better-whitespace",
		branch = "master",
		commit = "c5afbe91d29c5e3be81d5125ddcdc276fd1f1322",
		config = function()
			require("plugins.vim-better-whitespace")
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		tag = "v0.3",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.gitsigns")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		branch = "0.5-compat",
		commit = "47cfda2c6711077625c90902d7722238a8294982",
		run = ":TSUpdate",
		event = "BufRead",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"tpope/vim-fugitive",
		tag = "v3.4",
	})
	use({
		"tpope/vim-unimpaired",
		branch = "master",
		commit = "e4006d68cd4f390efef935bc09be0ce3bd022e72",
	})
	use({
		"tpope/vim-sleuth",
		tag = "v1.2",
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		branch = "main",
		commit = "0bf6d358b86ae13f87cd45f6446e7b3ab924d060",
		requires = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			"lewis6991/gitsigns.nvim",
		},
	})
	use({
		"neovim/nvim-lspconfig",
		branch = "master",
		commit = "0d2fb782cac8a19df0c0d7715ad4cdab4c582e15",
	})
	use({
		"williamboman/nvim-lsp-installer",
		branch = "main",
		commit = "e65e4966e1b3db486ae548a5674f20a8416a42d0",
	})
	use({
		"hrsh7th/nvim-cmp",
		branch = "main",
		commit = "ae708ef3a44dfb0cb42d1aa901b4c57c2de53aa3",
		requires = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-omni",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"windwp/nvim-autopairs",
			"onsails/lspkind-nvim",
		},
		config = function()
			require("plugins.cmp")
		end,
	})
	use({
		"rafamadriz/friendly-snippets",
		branch = "main",
		commit = "a4105d7d463ee2a36dc2c28d243f1d2c5b41c142",
	})
	use({
		"folke/which-key.nvim",
		branch = "main",
		commit = "312c386ee0eafc925c27869d2be9c11ebdb807eb",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"windwp/nvim-autopairs",
		branch = "master",
		commit = "a9b6b98de3bacacc0c986d9b0673cae6a87c4a41",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	})
	use({
		"terrortylor/nvim-comment",
		branch = "main",
		commit = "6363118acf86824ed11c2238292b72dc5ef8bdde",
		event = "BufRead",
		config = function()
			require("nvim_comment").setup()
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.11.0",
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
		commit = "08e766c1467d3fa3b53ca1dafdfa9815ea830b3c",
		config = function()
			require("auto-session").setup({})
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		branch = "master",
		commit = "9e26823ea6c7361aba3253c8a5c56a6f35b4a0ee",
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
		tag = "v0.1.1",
	})
	use({
		"ggandor/lightspeed.nvim",
		branch = "main",
		commit = "9fddb6ebf4007eaa26f44cd31b5140cbd3bbb820",
	})
	use({
		"lervag/vimtex",
		tag = "v2.8",
		ft = { "tex" },
	})
end)

require("options")
require("mappings")
require("plugins.lsp")
