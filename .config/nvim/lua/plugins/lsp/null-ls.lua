local null_ls = require("null-ls")

local b = null_ls.builtins
local sources = {
	-- Lua
	b.formatting.stylua,

	-- Shell
	b.formatting.shfmt,
	b.formatting.prettier, -- YAML etc

	null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup({
	sources = sources,
	on_attach = require("plugins.lsp.config").on_attach,
})
