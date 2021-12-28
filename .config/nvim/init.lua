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
		commit = "789a00a653fcd726cbad1f630480f950c1578cfc",
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
		commit = "463637a3ac86dcaacbcd47aa608f53aaad749696",
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
		commit = "824c6941604fa8a7a4fe56fefcf36b46698314ee",
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
		commit = "e3506d575e120253b4aa47ec2100786fd1e9c38d",
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
		commit = "1b4b4b7a993aae6d6281bc98194675b97ce9e962",
		config = function()
			require("auto-session").setup({})
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		branch = "master",
		commit = "1ae4f0aa74f0b34222c5ef3281b34602a76b2b00",
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
		commit = "02c3138195c1608fa07b5fec73c3a0d3c0f9bc3e",
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
