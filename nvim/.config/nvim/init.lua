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
		commit = "969f2c5c90457612c09cf2a13fee1adaa986d350",
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
		branch = "master",
		commit = "e2a77a54a35642dd95310effe2bf4e36fff3af26",
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
		commit = "eaa5baec341a0b9dcf3621d886d77f4539f8a3c1",
		config = function()
			require("onenord").setup({
				fade_nc = false, -- Fade non-current windows, making them more distinguishable
			})
		end,
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		branch = "main",
		commit = "6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6",
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
		commit = "1b9157dd2d2b31d561c485b5c107dacb1dca6945",
		run = ":TSUpdate",
		event = "BufRead",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-context",
		branch = "master",
		commit = "2837cd67ccdc50b7c7fe5a6a8cb0ca8cc6e2aae3",
		requires = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufEnter" },
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
		commit = "dfdd5fab3c53c30f83c78ea351b9a8f65715a5b7",
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
		commit = "650ce7156ca7935e02934eef45b392957ea402e8",
		event = { "VimEnter" },
	})
	use({
		"williamboman/nvim-lsp-installer",
		branch = "main",
		commit = "4636219c9165739e40c46cf3d44c350ee7bebb15",
		after = { "nvim-lspconfig", "lsp_signature.nvim" },
		config = function()
			require("plugins.lsp")
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		branch = "main",
		commit = "15c7bf7c0dfb7c75eb526c53f9574633c13dc22d",
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
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("plugins.cmp")
		end,
	})
	use({
		"rafamadriz/friendly-snippets",
		branch = "main",
		commit = "d27a83a363e61009278b6598703a763ce9c8e617",
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
		commit = "4a95b3982be7397cd8e1370d1a09503f9b002dbf",
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
		commit = "3c69bab36569d5d0321351ec956fc43a8d409fb0",
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
		commit = "2c0103eb26b41cf4b58c3063d7549746d0f5fa73",
		config = function()
			require("plugins.auto-session")
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		branch = "master",
		commit = "3362b28f917acc37538b1047f187ff1b5645ecdd",
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
		commit = "c5b93fc1d76a708cb698417326e04f4786a38d90",
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
		commit = "adedd98f125d7507a1306cbbc8ec658aa29396db",
	})
end)

require("impatient")
require("options")
require("mappings")
