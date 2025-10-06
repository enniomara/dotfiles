local config = require("config.lsp.config")

vim.diagnostic.config({
	virtual_text = {
		current_line = false,
	},
	virtual_lines = {
		current_line = true,
	},
})

-- blink supports additional completion capabilities
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("lua_ls", {
	on_attach = config.on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			hint = {
				enable = true,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
vim.lsp.enable("lua_ls")

vim.lsp.config("gopls", {
	on_attach = config.on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			hints = {
				compositeLiteralFields = true,
				constantValues = true,
				parameterNames = true,
			},
		},
	},
})
vim.lsp.enable("gopls")

vim.lsp.config("yamlls", {
	on_attach = config.on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			customTags = {
				"!And",
				"!And sequence",
				"!If",
				"!If sequence",
				"!Not",
				"!Not sequence",
				"!Equals",
				"!Equals sequence",
				"!Or",
				"!Or sequence",
				"!FindInMap",
				"!FindInMap sequence",
				"!Base64",
				"!Join",
				"!Join sequence",
				"!Cidr",
				"!Ref",
				"!Sub",
				"!Sub sequence",
				"!GetAtt",
				"!GetAZs",
				"!ImportValue",
				"!ImportValue sequence",
				"!Select",
				"!Select sequence",
				"!Split",
				"!Split sequence",
			},
		},
	},
})
vim.lsp.enable("yamlls")

-- LSP for nix
vim.lsp.config("nil_ls", {
	on_attach = config.on_attach,
	capabilities = capabilities,
	settings = {
		["nil"] = {
			formatting = {
				command = { "alejandra" },
			},
		},
	},
})
vim.lsp.enable("nil_ls")

vim.lsp.config("pyright", {
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("pyright")

vim.lsp.config("ts_ls", {
	on_attach = function(client, bufnr)
		-- the formatting by ts_ls seems to be clashing with eslint for some
		-- reason. Disable it and let eslint be the primary formatter
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		config.on_attach(client, bufnr)
	end,
	capabilities = capabilities,
})
vim.lsp.enable("ts_ls")

vim.lsp.config("clojure_lsp", {
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("clojure_lsp")

vim.lsp.config("eslint", {
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("eslint")

vim.lsp.config("rust_analyzer", {
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("rust_analyzer")

vim.lsp.config("astro", {
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("astro")

vim.lsp.config("elmls", {
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("elmls")

vim.lsp.config("terraformls", {
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("terraformls")

vim.lsp.config("bashls", {
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("bashls")

vim.lsp.config("ruff", {
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("ruff")

vim.lsp.config("elixirls", {
	cmd = { "elixir-ls" },
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("elixirls")

vim.lsp.config("zls", {
	on_attach = config.on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("zls")
