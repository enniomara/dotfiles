local lspinstall = require("lspinstall")
local lspconfig = require("lspconfig")

local M = {}
M.setup = function (on_attach, capabilities)
	lspinstall.setup() -- important

	local servers = lspinstall.installed_servers()
	for _, server in pairs(servers) do
		lspconfig[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end

	-- add vim to the list of globals
	lspconfig.lua.setup({
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
end

return M
