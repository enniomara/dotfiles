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
		"nvim-telescope/telescope.nvim",
		branch = "master",
		commit = "404d2b5f1080b352e3b093bf9b2d690eb1931743",
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
		commit = "34154ee1cadbb01186bb8aeea18ca3a6b8e0ddde",
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		branch = "main",
		commit = "59e38e1661ffdd586cb7fc22ca0b5a05c7caf988",
		run = "make",
	})
	use({
		"akinsho/bufferline.nvim",
		branch = "master",
		commit = "782fab8a2352e872dc991c42f806dae18e848b2d",
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

	use({ -- used for formatting mainly
		"jose-elias-alvarez/null-ls.nvim",
		branch = "main",
		commit = "a3ded9b1525b06136e58a95f4d9ed2f090c0f908",
		requires = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			"lewis6991/gitsigns.nvim",
		},
	})
	use({
		"neovim/nvim-lspconfig",
		branch = "master",
		commit = "e3d0992737985c52b93b0cef338895c164dd1cfb",
	})
	use({
		"williamboman/nvim-lsp-installer",
		branch = "main",
		commit = "35d4b08d60c17b79f8e16e9e66f0d7693c99d612",
	})
	use({
		"hrsh7th/nvim-cmp",
		branch = "main",
		commit = "c2a9e0ccaa5c441821f320675c559d723df70f3d",
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
		commit = "05bfa7681b8f11b664fab657001c2efb6f3ec85e",
	})
	use({
		"folke/which-key.nvim",
		branch = "main",
		commit = "d3032b6d3e0adb667975170f626cb693bfc66baa",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"windwp/nvim-autopairs",
		branch = "master",
		commit = "b5d077d2a055485a00846a107c777321feed1d29",
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
		tag = "v2.10.5",
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
		commit = "5f2a9d7e45133be33a1dae3580089e257824a907",
		config = function()
			require("auto-session").setup({})
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		branch = "master",
		commit = "e6b6caa93b900c86d8c299d92282feae3934ec39",
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
	})
	use({
		"ray-x/lsp_signature.nvim",
		tag = "v0.1.1",
	})
	use({
		"ggandor/lightspeed.nvim",
		branch = "main",
		commit = "c0ebc350e65b1f7370ec2d5b6f83bdc1ce602761",
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
