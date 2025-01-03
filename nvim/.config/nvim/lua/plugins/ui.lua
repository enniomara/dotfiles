return {
	{
		"lewis6991/gitsigns.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.gitsigns")
		end,
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config.neotree")
		end,
		keys = {
			{ "<leader>dd", "<cmd>Neotree toggle=true<cr>", desc = "Explorer Neotree" },
		},
	},
	{
		"folke/tokyonight.nvim",
		version = '*',
		opts = {
			style = "moon",
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "*",
		event = "BufRead",
		main = "ibl",
		opts = {
			scope = {
				enabled = false,
			},
		},
	},
	{
		"kevinhwang91/nvim-bqf",
		version = "*",
		ft = "qf",
	},
}
