require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	ignore_install = { "phpdoc" }, -- not installing for some reason
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
})

local gofolds = [[
	[
	(const_declaration)
	(expression_switch_statement)
	(for_statement)
	(func_literal)
	(function_declaration)
	(if_statement)
	(import_declaration)
	(method_declaration)
	(type_declaration)
	(var_declaration)
	(argument_list)
	(composite_literal)
	] @fold
]]
require("vim.treesitter.query").set_query("go", "folds", gofolds)
