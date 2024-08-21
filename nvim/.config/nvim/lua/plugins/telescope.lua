return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"princejoogie/dir-telescope.nvim",
		},
		config = function()
			require("config.telescope")
		end,
	},
	"nvim-telescope/telescope-ui-select.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"princejoogie/dir-telescope.nvim",
		version = "*",
	},
}
