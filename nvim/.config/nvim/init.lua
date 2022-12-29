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
		"lewis6991/impatient.nvim",
		branch = "main",
		commit = "c90e273f7b8c50a02f956c24ce4804a47f18162e",
	})
	use({
		"nvim-neo-tree/neo-tree.nvim",
		tag = "v2.6",
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
		commit = "0b1c41ad8052badca6e72eafa4bc5481152e483e",
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
		commit = "3fca21ce5a849b0a5f4c97a2e6db8e61669cc617",
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
		commit = "ee3e9f4dc0e5ee9e2bfb1ee47638375840b8fe0f",
		run = ":TSUpdate",
		event = "BufRead",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-context",
		branch = "master",
		commit = "d28654b012d4c56beafec630ef7143275dff76f8",
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
		commit = "647a1eeeefc43ce15d941972642210637c370471",
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
		commit = "9c73b57ed03ad0a906e2cdc2fc348bf86ae53e3a",
		event = { "VimEnter" },
	})
	use({
		"williamboman/mason.nvim",
		branch = "main",
		commit = "1592493e3406c271e9128b4d424731e25f1ff2a1",
		after = { "nvim-lspconfig" },
		-- configuration done in mason-lspconfig.nvim
	})
	use({
		"williamboman/mason-lspconfig.nvim",
		branch = "main",
		commit = "aa25b4153d2f2636c3b3a8c8360349d2b29e7ae3",
		after = { "nvim-lspconfig", "mason.nvim", "lsp_signature.nvim" },
		config = function()
			require("plugins.lsp")
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		branch = "main",
		commit = "c49ad26e894e137e401b1d294948c46327877eaf",
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
		commit = "1a6a02350568d6830bcfa167c72f9b6e75e454ae",
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
		commit = "7bb563ff2d811a63b207e9de63e3e9c0877cb6d5",
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
		commit = "32a7382a75a52e8ad05f4cec7eeb8bbfbe80d461",
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
		tag = "v0.9.9",
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
end)

require("impatient")
require("options")
require("mappings")

