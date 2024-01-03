require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = false, -- managed via nix
})

local config = require("plugins.lsp.config")
local lspconfig = require("lspconfig")

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup({
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

-- LSP for nix
lspconfig.rnix.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})

lspconfig.pyright.setup({
	on_attach = config.on_attach,
	capabilities = capabilities,
})
lspconfig.tsserver.setup({
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

require("lsp_signature").setup({})
