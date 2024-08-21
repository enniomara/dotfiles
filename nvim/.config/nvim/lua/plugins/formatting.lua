return {
	{
		"stevearc/conform.nvim",
		version = "*",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {},
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true })
				end,
				mode = { "n", "v" },
				desc = "Format: Buffer",
			},
		},
		config = function()
			local prettier_formatters = { "prettier" }
			require("conform").setup({
				default_format_opts = {
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					css = prettier_formatters,
					graphql = prettier_formatters,
					html = prettier_formatters,
					javascript = prettier_formatters,
					javascriptreact = prettier_formatters,
					json = prettier_formatters,
					json5 = prettier_formatters,
					jsonc = prettier_formatters,
					markdown = prettier_formatters,
					typescript = prettier_formatters,
					typescriptreact = prettier_formatters,
					yaml = prettier_formatters,

					elm = { "elm_format" },
					lua = { "stylua" },
					python = { "isort", "black" },
					sh = { "shfmt" },
					sql = { "sqlfluff" },
					nix = { "nixfmt" },
					["*"] = { "trim_whitespace" },
				},
				formatters = {
					black = {
						args = { "--fast" },
					},
				},
			})
		end,
	},
}
