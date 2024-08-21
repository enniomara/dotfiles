return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"lewis6991/gitsigns.nvim",
		},
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("config.lsp.null-ls")
		end,
	},
}
