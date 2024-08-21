return {
	{
		"lewis6991/gitsigns.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.gitsigns")
		end,
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config.neotree")
		end,
		keys = {
			{ "<leader>dd", "<cmd>Neotree toggle=true<cr>", desc = "Explorer Neotree" },
		},
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "moon",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		version = "*",
		keys = {
			{
				"<S-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<leader>snd",
				function()
					require("noice").cmd("dismiss")
				end,
				desc = "Dismiss All",
			},
			{
				"<leader>snt",
				function()
					require("noice").cmd("telescope")
				end,
				desc = "Open notifications in telescope",
			},
			{
				"<leader>sna",
				function()
					require("noice").cmd("all")
				end,
				desc = "Open all notifications",
			},
		},
		opts = {
			routes = {
				{
					-- show @ recording messages in mini
					view = "mini",
					filter = { event = "msg_showmode" },
				},
				{
					-- route all msg_show messages to mini
					view = "mini",
					filter = {
						event = "msg_show",
						kind = "",
					},
				},
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
				signature = {
					enabled = false,
				},
			},
			cmdline = {
				enabled = true,
				view = "cmdline",
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
			views = {
				notify = {
					-- use minimal theme to render notification
					render = "minimal",
				},
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "*",
		event = "BufRead",
		main = "ibl",
		opts = {
			scope = {
				enabled = false,
			},
		},
	},
	{
		"kevinhwang91/nvim-bqf",
		version = "*",
		ft = "qf",
	},
}
