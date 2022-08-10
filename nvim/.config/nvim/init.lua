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
		commit = "2aa872de40dbbebe8e2d3a0b8c5651b81fe8b235",
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
		commit = "83c760cbaccd8e4c69a55b0b8c7ccd3fdc4cf689",
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
		commit = "c2021ba34aecd8027437dadd27edf9fc949c9aa8",
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
		tag = "v2.5.1",
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
		commit = "2139fca70c909266a3b23a080ce4315e76da8267",
		run = ":TSUpdate",
		event = "BufRead",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-context",
		branch = "master",
		commit = "0d086d23c0742404e9bd52977712619a621c3da9",
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
		commit = "5b745e5fa2a18a2c0df8966080f4321fad4f42d7",
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
		commit = "dcb7ebb36f0d2aafcc640f520bb1fc8a9cc1f7c8",
		event = { "VimEnter" },
	})
	use({
		"williamboman/nvim-lsp-installer",
		branch = "main",
		commit = "bfa74f4ffa16b6d49be7118caf542d54d13b7bc0",
		after = { "nvim-lspconfig", "lsp_signature.nvim" },
		config = function()
			require("plugins.lsp")
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		branch = "main",
		commit = "706371f1300e7c0acb98b346f80dad2dd9b5f679",
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
		commit = "5632135df892a742e5c3bbf97f0f634e273254d4",
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
		commit = "972a7977e759733dd6721af7bcda7a67e40c010e",
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
		commit = "27f9416aeb0441fbba8098301c9bd3d4aa011291",
		event = "BufRead",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.19.1",
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
		commit = "50f5f2eaa7ff825c7036dc3c9981ebae7584b48e",
		config = function()
			require("plugins.auto-session")
		end,
	})
	use({
		"hoob3rt/lualine.nvim",
		branch = "master",
		commit = "5f68f070e4f7158517afc55f125a6f5ed1f7db47",
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
		commit = "a4b4277d143270c6a7d85ef2e1574a1bbeab6677",
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
		commit = "360ccdc01b18cd434588c34e15e5ea382b436de8",
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
		commit = "328f20c1d0e39ed30df3fc6334c093e8e8b72453",
		config = function()
			require("nvim-surround").setup({})
		end,
	})
end)

require("impatient")
require("options")
require("mappings")
