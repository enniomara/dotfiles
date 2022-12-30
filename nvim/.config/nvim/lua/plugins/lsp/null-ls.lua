local null_ls = require("null-ls")

local b = null_ls.builtins
local sources = {
	-- Lua
	b.formatting.stylua,

	-- Shell
	b.formatting.shfmt,
	b.diagnostics.shellcheck,
	null_ls.builtins.code_actions.shellcheck,

	b.formatting.prettier, -- YAML etc
	b.diagnostics.yamllint,

	b.diagnostics.cfn_lint,

	b.code_actions.eslint,
	b.diagnostics.eslint.with({
		method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}),

	-- python
	b.diagnostics.flake8.with({ extra_args = { "--max-line-length=100" } }), -- 100 because wide screens are a thing,
	b.formatting.black.with({ extra_args = { "--fast" } }),
	b.formatting.isort,
}

null_ls.setup({
	sources = sources,
	on_attach = require("plugins.lsp.config").on_attach,
})
