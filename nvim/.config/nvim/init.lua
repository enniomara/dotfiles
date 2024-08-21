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
