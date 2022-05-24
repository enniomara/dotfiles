local config = require("plugins.lsp.config")

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lspinstall = require("plugins.lspinstall")
lspinstall.setup(config.on_attach, capabilities)

require("lsp_signature").setup({})
