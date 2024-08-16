vim.g.mapleader = " "

-- Needed so that packer knows how to load the treesitter grammars installed by
-- nix
vim.cmd([[packloadall ]])

require("lazy").setup({
	-- Problems with treesitter and nix, the dependencies for grammas were not
	-- loaded propery when resetting packpath and rtp
	performance = {
		reset_packpath = false,
		rtp = {
			reset = false,
		},
	},
	spec = {
		{ import = "plugins" },
		{
			"nvim-treesitter/nvim-treesitter",
			dependencies = {
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			event = "BufRead",
			build = ":TsUpdate",
			config = function()
				require("config.treesitter")
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			event = { "BufRead" },
			config = function()
				require("treesitter-context").setup()
			end,
		},
		{
			"tpope/vim-fugitive",
			version = "*",
			cmd = "Git",
		},
		{
			"tpope/vim-unimpaired",
			event = "BufRead",
		},
		{
			"tpope/vim-sleuth",
			version = "*",
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{
					"williamboman/mason.nvim",
					version = "*",
				},
				{
					"williamboman/mason-lspconfig.nvim",
					version = "*",
				},
			},
			config = function()
				require("config.lsp")
			end,
			event = { "BufReadPre", "BufNewFile" },
		},
		{
			"rmagatti/auto-session",
			keys = {
				{
					"<Leader>ql",
					":SessionRestore<CR>",
					desc = "Restore last session",
				},
			},
			opts = {
				auto_restore_enabled = false,
				pre_save_cmds = { "Neotree action=close" },
			},
		},
		{
			"hoob3rt/lualine.nvim",
			dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("lualine").setup({
					options = {
						theme = "tokyonight",
					},
					sections = {
						lualine_x = {
							"diff",
							{
								"diagnostics",
								sources = { "nvim_diagnostic" },
								symbols = { error = " ", warn = " ", info = " ", hint = " " },
								color = {},
							},
							"encoding",
							"fileformat",
							"filetype",
						},
					},
					tabline = {
						lualine_a = {
							{
								"filename",
								path = 1,
							},
						},
						lualine_y = {
							"tabs",
						},
					},
				})
			end,
		},
		{
			"lervag/vimtex",
			version = "*",
			ft = { "tex" },
		},
		{
			"tpope/vim-dadbod",
			opt = true,
			dependencies = {
				{
					"kristijanhusak/vim-dadbod-ui",
				},
			},
			cmd = {
				"DBUIToggle",
				"DBUI",
				"DBUIAddConnection",
				"DBUIFindBuffer",
				"DBUIRenameBuffer",
				"DBUILastQueryInfo",
			},
		},
		-- Debugger
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				-- Creates a beautiful debugger UI
				{
					"rcarriga/nvim-dap-ui",
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
		{
			"nvim-neotest/neotest",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-neotest/neotest-go",
			},
			version = "*",
			keys = {
				{
					"<leader>tr",
					function()
						require("neotest").run.run()
					end,
					desc = "Test: Run Single Function",
				},
				{
					"<leader>tt",
					function()
						require("neotest").run.run(vim.fn.expand("%"))
					end,
					desc = "Test: Run Current File",
				},
				{
					"<leader>tT",
					function()
						require("neotest").run.run(vim.loop.cwd())
					end,
					desc = "Test: Run All Tests",
				},
				{
					"<leader>tl",
					function()
						require("neotest").run.run_last()
					end,
					desc = "Test: Run All Tests",
				},
				{
					"<leader>te",
					function()
						require("neotest").output.open({ enter = true, auto_close = true })
					end,
					desc = "Test: Open single test output",
				},
				{
					"<leader>to",
					function()
						require("neotest").summary.toggle()
					end,
					desc = "Test: Open Test Summary",
				},
				{
					"<leader>tO",
					function()
						require("neotest").output_panel.toggle()
					end,
					desc = "Test: Open Output Panel",
				},
			},
			config = function()
				-- get neotest namespace (api call creates or returns namespace)
				local neotest_ns = vim.api.nvim_create_namespace("neotest")
				vim.diagnostic.config({
					virtual_text = {
						format = function(diagnostic)
							local message = diagnostic.message
								:gsub("\n", " ")
								:gsub("\t", " ")
								:gsub("%s+", " ")
								:gsub("^%s+", "")
							return message
						end,
					},
				}, neotest_ns)
				require("neotest").setup({
					-- your neotest config here
					adapters = {
						require("neotest-go"),
					},
				})
			end,
		},
		{
			"robitx/gp.nvim",
			event = "VeryLazy",
			config = function()
				require("gp").setup({
					openai_api_key = { "cat", os.getenv("HOME") .. "/.config/openai/api.key" },
				})

				vim.keymap.set(
					{ "n", "v" },
					"<leader>aC",
					":GpChatNew vsplit<cr>",
					{ desc = "AI (GP): Start new chat" }
				)
				vim.keymap.set({ "n", "v" }, "<leader>aT", ":GpChatToggle<cr>", { desc = "AI (GP): Toggle chat" })
			end,
		},
		{
			"olimorris/codecompanion.nvim",
			event = "VeryLazy",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
			},
			config = function()
				require("codecompanion").setup({
					adapters = {
						openai = function()
							return require("codecompanion.adapters").use("openai", {
								env = {
									api_key = string.format(
										"cmd:cat %s",
										os.getenv("HOME") .. "/.config/openai/api.key"
									),
								},
								schema = {
									model = { default = "gpt-4o-mini" },
								},
							})
						end,
					},
				})

				vim.keymap.set({ "n", "v" }, "<leader>ac", ":CodeCompanionChat<cr>", { desc = "AI: Start new chat" })
				vim.keymap.set({ "n", "v" }, "<leader>at", ":CodeCompanionToggle<cr>", { desc = "AI: Toggle chat" })
			end,
		},
	},
})

require("options")
require("mappings")
