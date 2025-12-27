vim.diagnostic.config({
	virtual_text = {
		current_line = false,
	},
	virtual_lines = {
		current_line = true,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("ennio.lsp", {}),
	callback = function(args)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "Code Action" })

		vim.keymap.set("n", "<leader>e", function()
			vim.diagnostic.open_float({ scope = "line" })
		end, { buffer = args.buf, desc = "Open Diagnostic Float" })

		vim.keymap.set("n", "<leader>fm", function()
			vim.lsp.buf.format({ async = true })
		end, { buffer = args.buf, desc = "Format Code" })

		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, {
				bufnr = args.buf,
			})
		end
	end,
})

vim.lsp.config("lua_ls", {
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
	settings = {
		["nil"] = {
			formatting = {
				command = { "alejandra" },
			},
		},
	},
})
vim.lsp.enable("nil_ls")

vim.lsp.enable("pyright")

vim.lsp.config("ts_ls", {
	on_attach = function(client)
		-- the formatting by ts_ls seems to be clashing with eslint for some
		-- reason. Disable it and let eslint be the primary formatter
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
})
vim.lsp.enable("ts_ls")

vim.lsp.enable("clojure_lsp")

vim.lsp.enable("eslint")

vim.lsp.enable("rust_analyzer")

vim.lsp.enable("astro")

vim.lsp.enable("elmls")

vim.lsp.enable("terraformls")

vim.lsp.enable("bashls")

vim.lsp.enable("ruff")

vim.lsp.enable("elixirls")

vim.lsp.enable("zls")

vim.lsp.enable("sqlls")
