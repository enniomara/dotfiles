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
			"nvim-neo-tree/neo-tree.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			config = function()
				require("plugins.neotree")
			end,
			keys = {
				{ "<leader>dd", "<cmd>Neotree toggle=true<cr>", desc = "Explorer Neotree" },
			},
		},
		{
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			cmd = "Telescope",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-fzf-native.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
				"princejoogie/dir-telescope.nvim",
			},
			config = function()
				require("plugins.telescope")
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"folke/tokyonight.nvim",
			opts = {
				style = "moon",
			},
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{
			"princejoogie/dir-telescope.nvim",
			version = "*",
		},
		{
			"ntpeters/vim-better-whitespace",
			config = function()
				require("plugins.vim-better-whitespace")
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			version = "*",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("plugins.gitsigns")
			end,
			event = { "BufReadPre", "BufNewFile" },
		},
		{
			"nvim-treesitter/nvim-treesitter",
			dependencies = {
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			event = "BufRead",
			build = ":TsUpdate",
			config = function()
				require("plugins.treesitter")
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
			"jose-elias-alvarez/null-ls.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"lewis6991/gitsigns.nvim",
			},
			event = { "BufRead", "BufNewFile" },
			config = function()
				require("plugins.lsp.null-ls")
			end,
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
				require("plugins.lsp")
			end,
			event = { "BufReadPre", "BufNewFile" },
		},
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-path",
				"windwp/nvim-autopairs",
				"onsails/lspkind-nvim",
			},
			event = { "InsertEnter", "CmdlineEnter" },
			config = function()
				require("plugins.cmp")
			end,
		},
		"rafamadriz/friendly-snippets",
		{
			"folke/which-key.nvim",
			version = "*",
			event = "VeryLazy",
			config = function()
				require("which-key").setup({})
			end,
		},
		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({
					disable_filetype = { "TelescopePrompt", "vim" },
				})
			end,
			event = { "InsertEnter" },
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
			"ray-x/lsp_signature.nvim",
			version = "*",
		},
		{
			"ggandor/leap.nvim",
			config = function()
				require("leap").create_default_mappings()
			end,
		},
		{
			"lervag/vimtex",
			version = "*",
			ft = { "tex" },
		},
		{
			"kevinhwang91/nvim-bqf",
			version = "*",
			ft = "qf",
		},
		{
			"abecodes/tabout.nvim",
			config = function()
				require("tabout").setup({})
			end,
			lazy = true,
			-- after = { "nvim-treesitter" },
		},
		{
			"kylechui/nvim-surround",
			version = "*",
			event = { "BufRead" },
			config = function()
				require("nvim-surround").setup({})
			end,
		},
		{
			"famiu/bufdelete.nvim",
			cmd = { "Bdelete", "Bwipeout" },
		},
		{
			"echasnovski/mini.ai",
			branch = "stable",
			event = "BufRead",
			config = function()
				require("mini.ai").setup()
			end,
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
			lazy = true,
			cmd = {
				"GpEnable", -- not a proper command, just want something to lazy load this plugin on
			},
			opts = {
				openai_api_key = { "cat", os.getenv("HOME") .. "/.config/openai/api.key" },
			},
		},
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local harpoon = require("harpoon")

				harpoon:setup()
				vim.keymap.set("n", "<leader>ke", function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end)
				vim.keymap.set("n", "<leader>ka", function()
					harpoon:list():add()
				end)
				vim.keymap.set("n", "<M-j>", function()
					harpoon:list():select(1)
				end)
				vim.keymap.set("n", "<M-k>", function()
					harpoon:list():select(2)
				end)
				vim.keymap.set("n", "<M-l>", function()
					harpoon:list():select(3)
				end)
				vim.keymap.set("n", "<M-;>", function()
					harpoon:list():select(4)
				end)

				vim.keymap.set("n", "<M-m>", function()
					harpoon:list():prev()
				end)
				vim.keymap.set("n", "<M-,>", function()
					harpoon:list():next()
				end)
			end,
		},
	},
})

require("options")
require("mappings")
