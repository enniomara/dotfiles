local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

vim.cmd([[packadd packer.nvim]])

require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("scrooloose/nerdtree")
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("shaunsingh/nord.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"sudormrfbin/cheatsheet.nvim",

		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
	use("ntpeters/vim-better-whitespace")
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("tpope/vim-fugitive")
	use("tpope/vim-sleuth")

	use({ -- used for formatting mainly
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	})
	use("neovim/nvim-lspconfig")
	use("kabouzeid/nvim-lspinstall")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip") -- Snippets plugin
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})
end)

require("options")
require("plugins.nvim-tree")
require("plugins.telescope")
require("plugins.cheatsheet")
require("plugins.bufferline")
require("plugins.vim-better-whitespace")
require("plugins.gitsigns")
require("plugins.treesitter")
require("plugins.null-ls")
require("plugins.lspconfig")
require("plugins.cmp")
require("mappings")
