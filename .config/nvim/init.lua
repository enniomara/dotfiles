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
		commit = "cf2d6d34282afd90f0f5d2aba265a23b068494c2",
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
		commit = "a8d3d541deaf802377d46b6daa3220ac364bf717",
		config = function()
			require("onenord").setup({
				fade_nc = false, -- Fade non-current windows, making them more distinguishable
			})
		end,
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
		commit = "7451dfc97d28e6783dbeb1cdcff12619a9323c98",
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
		branch = "master",
		commit = "1b74deaa322a2257f50daeb65093b9a0f41f2fd6",
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
		commit = "f992923d336e93c7f50fe9b35a07d5a92660ecaf",
	})
	use({
		"tpope/vim-sleuth",
		tag = "v1.2",
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		branch = "main",
		commit = "b1dbbc3807fcb82d6f562145debe6321610bef98",
		requires = {
			"nvim-lua/plenary.nvim",
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			require("plugins.lsp.null-ls")
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		branch = "master",
		commit = "2008c5cebf2b84c5e5f8a566480b022ab2e7ebab",
	})
	use({
		"williamboman/nvim-lsp-installer",
		branch = "main",
		commit = "8c32ee62b8a08f3a3d66d87a83b59bb37d57a388",
	})
	use({
		"hrsh7th/nvim-cmp",
		branch = "main",
		commit = "a7fea2ca9f29869c75c3e2ccb683e7740868ba8b",
		requires = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-omni",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
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
		commit = "2e575549910571ff5abb6b02178c69ad760a4e00",
	})
	use({
		"folke/which-key.nvim",
		branch = "main",
		commit = "28d2bd129575b5e9ebddd88506601290bb2bb221",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"windwp/nvim-autopairs",
		branch = "master",
		commit = "97e454ce9b1371373105716d196c1017394bc947",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	})
	use({
		"numToStr/Comment.nvim",
		branch = "master",
		commit = "af51a8af6b213336345f36fc7aba65f9c3316696",
		event = "BufRead",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.12.1",
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
		commit = "5860ae9369c86332ec45b38ab8308b9a4afb272c",
		config = function()
			require("plugins.auto-session")
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		branch = "master",
		commit = "98dc2dd3a2a07c251bcbd43048157aa56f901402",
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
		commit = "b04fc4e129512ce5ccd15acfe8388a898daa0a2a",
	})
	use({
		"lervag/vimtex",
		tag = "v2.8",
		ft = { "tex" },
	})
	use({
		"kevinhwang91/nvim-bqf",
		tag = "v0.2.0",
		ft = "qf",
	})
	use({
		"abecodes/tabout.nvim",
		branch = "master",
		commit = "6ff556b1b2274c8ba3eaedbf62339789e79baca8",
		config = function()
			require("tabout").setup({})
		end,
		after = { "nvim-treesitter" },
	})
	use({
		"ojroques/vim-oscyank",
		branch = "main",
		commit = "23b0846e26d946bda9ebcd267839fea83435aff2"
	})
end)

require("options")
require("mappings")
require("plugins.lsp")
