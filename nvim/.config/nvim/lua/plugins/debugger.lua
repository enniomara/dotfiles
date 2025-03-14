return {
	-- Debugger
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- Creates a beautiful debugger UI
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				config = function()
					local dap = require("dap")
					local dapui = require("dapui")
					dapui.setup({
						-- Set icons to characters that are more likely to work in every terminal.
						--    Feel free to remove or use ones that you like more! :)
						--    Don't feel like these are good choices.
						icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
						controls = {
							icons = {
								pause = "⏸",
								play = "▶",
								step_into = "⏎",
								step_over = "⏭",
								step_out = "⏮",
								step_back = "b",
								run_last = "▶▶",
								terminate = "⏹",
								disconnect = "⏏",
							},
						},
					})

					dap.listeners.after.event_initialized["dapui_config"] = dapui.open
					dap.listeners.before.event_terminated["dapui_config"] = dapui.close
					dap.listeners.before.event_exited["dapui_config"] = dapui.close
				end,
				keys = {
					{
						"<leader>do",
						function()
							require("dapui").toggle()
						end,
						desc = "Debug: Toggle UI",
					},
					{
						"<leader>dK",
						function()
							require("dapui").eval()
						end,
						desc = "Debug: Evaluate Expression",
					},
				},
			},

			-- Installs the debug adapters for you
			"williamboman/mason.nvim",
			{
				"jay-babu/mason-nvim-dap.nvim",
				version = "*",
				config = function()
					require("mason-nvim-dap").setup({
						-- Makes a best effort to setup the various debuggers with
						-- reasonable debug configurations
						automatic_setup = true,

						-- You can provide additional configuration to the handlers,
						-- see mason-nvim-dap README for more information
						handlers = {},

						-- You'll need to check that you have the required things installed
						-- online, please don't ask me how to install them :)
						ensure_installed = {
							-- Update this to ensure that you have the debuggers for the langs you want
							"delve",
						},
					})
				end,
			},

			-- Add your own debuggers here
			{
				"leoluz/nvim-dap-go",
				opts = {
					-- Additional dap configurations can be added.
					-- dap_configurations accepts a list of tables where each entry
					-- represents a dap configuration. For more details do:
					-- :help dap-configuration
					dap_configurations = {
						{
							-- Must be "go" or it will be ignored by the plugin
							type = "go",
							name = "Attach remote",
							mode = "remote",
							request = "attach",
						},
					},
					-- delve configurations
					delve = {
						-- the path to the executable dlv which will be used for debugging.
						-- by default, this is the "dlv" executable on your PATH.
						path = "dlv",
						-- time to wait for delve to initialize the debug session.
						-- default to 20 seconds
						initialize_timeout_sec = 20,
						-- a string that defines the port to start delve debugger.
						-- default to string "${port}" which instructs nvim-dap
						-- to start the process in a random available port
						port = "${port}",
						-- additional args to pass to dlv
						args = {},
						-- the build flags that are passed to delve.
						-- defaults to empty string, but can be used to provide flags
						-- such as "-tags=unit" to make sure the test suite is
						-- compiled during debugging, for example.
						-- passing build flags using args is ineffective, as those are
						-- ignored by delve in dap mode.
						build_flags = "",
					},
				},
			},
		},
		keys = {
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Start/Continue",
			},
			{
				"<leader>dl",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step Into",
			},
			{
				"<leader>dj",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step Over",
			},
			{
				"<leader>dh",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step Out",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "[D]ebug: Toggle [b]reakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "[D]ebug: Set [B]reakpoint with Condition",
			},
		},
	},
}
