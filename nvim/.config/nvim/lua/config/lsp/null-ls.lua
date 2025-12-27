local null_ls = require("null-ls")

local b = null_ls.builtins
local sources = {
	-- Lua
	b.formatting.stylua,

	-- Shell
	b.formatting.shfmt,

	b.formatting.prettier, -- YAML etc
	b.diagnostics.yamllint,

	b.diagnostics.cfn_lint,

	-- elm
	b.formatting.elm_format,

	-- golang
	b.diagnostics.golangci_lint,

	-- nix
	null_ls.builtins.formatting.alejandra,

	-- sql
	null_ls.builtins.diagnostics.sqlfluff.with({
		extra_args = { "--dialect", "postgres" }, -- change to your dialect
	}),
	null_ls.builtins.formatting.sqlfluff.with({
		extra_args = { "--dialect", "postgres" }, -- change to your dialect
	}),
}

null_ls.setup({
	sources = sources,
})
