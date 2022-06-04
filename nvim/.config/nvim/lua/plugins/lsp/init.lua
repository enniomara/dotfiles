require("nvim-lsp-installer").setup({
	automatic_installation = true,
})
local config = require("plugins.lsp.config")
local lspconfig = require("lspconfig")

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lspconfig.sumneko_lua.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
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
			buildFlags = {
				"-tags=requireDB,requireAWS,aws",
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

require("lsp_signature").setup({})
