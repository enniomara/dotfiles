-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
	close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	default_component_configs = {
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "ﰊ",
			default = "*",
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = false,
		},
		git_status = {
			symbols = {
				-- Change type
				added = "+", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "D", -- this can only be used in the git_status source
				renamed = "R", -- this can only be used in the git_status source
				-- Status type
				untracked = "?",
				ignored = "",
				unstaged = "M",
				staged = "",
				conflict = "",
			},
		},
	},
	window = {
		position = "left",
		width = 40,
		mappings = {
			-- ["<space>"] = "toggle_node",
			["<2-LeftMouse>"] = "open",
			["<cr>"] = "open",
			["o"] = "open",
			["S"] = "open_split",
			["s"] = "open_vsplit",
			["t"] = "open_tabnew",
			["C"] = "close_node",
			["<bs>"] = "navigate_up",
			["."] = "set_root",
			["H"] = "toggle_hidden",
			["R"] = "refresh",
			["/"] = "fuzzy_finder",
			["f"] = "filter_on_submit",
			["<c-x>"] = "clear_filter",
			["a"] = "add",
			["A"] = "add_directory",
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy", -- takes text input for destination
			["m"] = "move", -- takes text input for destination
			["q"] = "close_window",
		},
	},
	nesting_rules = {},
	filesystem = {
		filtered_items = {
			visible = true, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_by_name = {
				".DS_Store",
				"thumbs.db",
				"node_modules",
			},
			never_show = {},
		},
		follow_current_file = true,
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function(_)
				-- Set relative numbers on neo-tree
				vim.opt.relativenumber = true
			end,
		},
	},
})
