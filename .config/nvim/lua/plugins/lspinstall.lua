local lsp_installer = require("nvim-lsp-installer")

local M = {}

M.setup = function(on_attach, capabilities)
	lsp_installer.on_server_ready(function(server)
		local opts = {
			on_attach = on_attach,
			capabilities = capabilities,
		}

		if server.name == "sumneko_lua" then
			opts.settings = {
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
			}
		end
		if server.name == "gopls" then
			opts.settings = {
				gopls = {
					buildFlags = {
						"-tags=requireDB,requireAWS,aws",
					},
				},
			}
		end

		if server.name == "yamlls" then
			opts.settings = {
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
			}
		end

		-- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
		server:setup(opts)
		vim.cmd([[ do User LspAttachBuffers ]])
	end)
end
return M
