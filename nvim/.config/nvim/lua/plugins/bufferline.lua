require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "neo-tree",
				text = "",
				padding = 1,
			},
		},
		tab_size = 20,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, _, _)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	},
})
