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
		commit = "bcc22509bdf1c9d9e63e5e44ad00f5fcf581d651",
	})
	use({
		"nvim-neo-tree/neo-tree.nvim",
		tag = "v2.6",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugins.neotree")
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		branch = "master",
		commit = "795a63ed293ba249a588e9e67aa1f2cec82028e8",
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
		commit = "bc9472cfa7fb29fe06dec66f75b12d69bca2c6be",
		config = function()
			require("onenord").setup({
				fade_nc = false, -- Fade non-current windows, making them more distinguishable
			})
		end,
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		branch = "main",
		commit = "2330a7eac13f9147d6fe9ce955cb99b6c1a0face",
		run = "make",
	})
	use({
		"akinsho/bufferline.nvim",
		branch = "master",
		commit = "af158e4477a08be3645faf91cfb772f898c132f0",
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
		commit = "aaf5d370f477dd2ff5f7704fed93483f46d0eef0",
		run = ":TSUpdate",
		event = "BufRead",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"tpope/vim-fugitive",
		tag = "v3.4",
		event = "BufRead",
	})
	use({
		"tpope/vim-unimpaired",
		branch = "master",
		commit = "efdc6475f7ea789346716dabf9900ac04ee8604a",
		event = "BufRead",
	})
	use({
		"tpope/vim-sleuth",
		tag = "v1.2",
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		branch = "main",
		commit = "dcad76eb1abb80cf3a27208823becbf62547abf8",
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
		commit = "b86a37caf7a4e53e62ba883aef5889b590260de9",
	})
	use({
		"williamboman/nvim-lsp-installer",
		branch = "main",
		commit = "f5569f6785e675aaa01db9e44e0afcd065d6ba15",
		config = function()
			require("plugins.lsp")
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		branch = "main",
		commit = "a226b6a4ff72e5e809ed17734318233fb25c87f3",
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
		commit = "4ef45d099453a26d23084a04ae7dced19e6d5ae5",
	})
	use({
		"folke/which-key.nvim",
		branch = "main",
		commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"windwp/nvim-autopairs",
		branch = "master",
		commit = "b9cc0a26f3b5610ce772004e1efd452b10b36bc9",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	})
	use({
		"numToStr/Comment.nvim",
		branch = "master",
		commit = "cc87c897458a16c5187abd915502fd48c9f23532",
		event = "BufRead",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.18.4",
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
		commit = "7c9477614fb95b103c277a98bf3f588e337cd7ac",
		config = function()
			require("plugins.auto-session")
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		branch = "master",
		commit = "619ededcff79e33a7e0ea677881dd07957449f9d",
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
		commit = "8a51f290da601f79efb7693e58dacc0a6e18239a",
	})
	use({
		"lervag/vimtex",
		tag = "v2.8",
		ft = { "tex" },
	})
	use({
		"kevinhwang91/nvim-bqf",
		tag = "v0.3.3",
		ft = "qf",
	})
	use({
		"abecodes/tabout.nvim",
		branch = "master",
		commit = "be655cc7ce0f5d6d24eeaf8b36e82693fd2facca",
		config = function()
			require("tabout").setup({})
		end,
		after = { "nvim-treesitter" },
	})
	use({
		"ojroques/vim-oscyank",
		branch = "main",
		commit = "ebcb47da66329d2c654e380d87879a935576c176",
	})
end)

require("impatient")
require("options")
require("mappings")
