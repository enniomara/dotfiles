require("nvim-treesitter.configs").setup({
	ensure_installed = {},
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

	textobjects = {
		move = {
			enable = true,
			goto_next_start = {
				["]f"] = "@function.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
			},
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
vim.treesitter.query.set("go", "folds", gofolds)
