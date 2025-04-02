require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = false, -- managed via nix
})

local config = require("config.lsp.config")
local lspconfig = require("lspconfig")

vim.diagnostic.config({
	virtual_text = {
		current_line = true,
		severity = { min = "INFO", max = "WARN" },
	},
	virtual_lines = {
		current_line = true,
		severity = { min = "ERROR" },
	},
})

-- blink supports additional completion capabilities
local capabilities = require("blink.cmp").get_lsp_capabilities()

lspconfig.lua_ls.setup({
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

lspconfig.gopls.setup({
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

lspconfig.yamlls.setup({
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

-- LSP for nix
lspconfig.nil_ls.setup({
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

lspconfig.pyright.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})
lspconfig.ts_ls.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})
lspconfig.clojure_lsp.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})
lspconfig.eslint.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})
lspconfig.rust_analyzer.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})

lspconfig.astro.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})

lspconfig.elmls.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})

lspconfig.terraformls.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})

lspconfig.bashls.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})

lspconfig.ruff.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})
lspconfig.elixirls.setup({
	cmd = { "elixir-ls" },
	on_attach = config.on_attach,
	capabilities = capabilities,
})
lspconfig.zls.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})
