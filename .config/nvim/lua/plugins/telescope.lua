require("telescope").setup({
	defaults = {
		file_ignore_patterns = { ".git" },
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
	},
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
