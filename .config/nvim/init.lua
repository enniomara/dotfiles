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
		tag = "1.6.5",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.nvim-tree")
		end,
	})
	use({
		"shaunsingh/nord.nvim",
		branch = "master",
		commit = "467d684f296a57b0069ff4ee9566df439511efe3",
	})
	use({
		"nvim-telescope/telescope.nvim",
		branch = "master",
		commit = "729492406ec3b545c4ecf2beadf7bd30c81e70e4",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
		lock = true,
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		lock = true,
	})
	use({
		"sudormrfbin/cheatsheet.nvim",

		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("plugins.cheatsheet")
		end,
		lock = true,
	})
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
		lock = true,
	})
	use({
		"ntpeters/vim-better-whitespace",
		config = function()
			require("plugins.vim-better-whitespace")
		end,
		lock = true,
	})
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.gitsigns")
		end,
		lock = true,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		event = "BufRead",
		config = function()
			require("plugins.treesitter")
		end,
		lock = true,
	})
	use({ "tpope/vim-fugitive", lock = true })
	use({ "tpope/vim-unimpaired", lock = true })
	use({ "tpope/vim-sleuth", lock = true })

	use({ -- used for formatting mainly
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			"lewis6991/gitsigns.nvim",
		},
		lock = true,
	})
	use({
		"neovim/nvim-lspconfig",
		lock = true,
	})
	use({
		"williamboman/nvim-lsp-installer",
		lock = true,
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"windwp/nvim-autopairs",
			"onsails/lspkind-nvim",
		},
		config = function()
			require("plugins.cmp")
		end,
		lock = true,
	})
	use("rafamadriz/friendly-snippets")
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
		lock = true,
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
		lock = true,
	})
	use({
		"terrortylor/nvim-comment",
		event = "BufRead",
		config = function()
			require("nvim_comment").setup()
		end,
		lock = true,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
				filetype_exclude = { "help" },
				show_trailing_blankline_indent = false,
			})
		end,
		lock = true,
	})
	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({})
		end,
		lock = true,
	})
	use({
		"hoob3rt/lualine.nvim",
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
							sources = { "nvim_lsp" },
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
		lock = true,
	})
	use({
		"ray-x/lsp_signature.nvim",
		lock = true,
	})
	use({ "ggandor/lightspeed.nvim", lock = true })
end)

require("options")
require("mappings")
require("plugins.lsp")
