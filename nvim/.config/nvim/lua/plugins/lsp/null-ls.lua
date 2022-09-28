local null_ls = require("null-ls")

local b = null_ls.builtins
local sources = {
	-- Lua
	b.formatting.stylua,

	-- Shell
	b.formatting.shfmt,
	b.formatting.prettier, -- YAML etc
	b.diagnostics.yamllint,
	b.diagnostics.shellcheck,

	b.diagnostics.cfn_lint,

	b.code_actions.eslint,
	b.diagnostics.eslint.with({
		method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}),

	null_ls.builtins.code_actions.shellcheck,
}

null_ls.setup({
	sources = sources,
	on_attach = require("plugins.lsp.config").on_attach,
})
