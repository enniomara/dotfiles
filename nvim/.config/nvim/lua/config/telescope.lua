local lga_actions = require("telescope-live-grep-args.actions")

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { ".git/" },
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden", -- so that it shows dotfiles
		},
		layout_config = {
			horizontal = {
				preview_width = 0.55,
				results_width = 0.8,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		file_browser = {
			hidden = true,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		live_grep_args = {
			auto_quoting = true,
			mappings = { -- extend mappings
				i = {
					["<C-k>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob **/ /**" }),
					-- freeze the current list and start a fuzzy search in the frozen list
					["<C-space>"] = lga_actions.to_fuzzy_refine,
				},
			},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
