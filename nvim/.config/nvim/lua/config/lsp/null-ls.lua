local null_ls = require("null-ls")
local h = require("null-ls.helpers")
local u = require("null-ls.utils")

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
	b.diagnostics.golangci_lint.with({
		ignore_stderr = false,
		args = function(params)
			local path = u.root_pattern("go.mod")(params.bufname)
			return {
				"run",
				"--fix=false",
				"--out-format=json",
				"--path-prefix",
				-- Nulls requires the full file path to show diagnostics. By default it sets the path prefix to $ROOT,
				-- which points to the repo root. Since we're changing CWD below, the repo root will lead to an incorrect path.
				path,
			}
		end,
		debug = true,
		cwd = h.cache.by_bufnr(function(params)
			-- start golangcilint where the go.mod is located at. Without this golint will not start since it cannot find the project root
			return u.root_pattern("go.mod")(params.bufname)
		end),
	}),

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
	on_attach = require("config.lsp.config").on_attach,
})
