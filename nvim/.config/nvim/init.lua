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
	defaults = {
		cond = vim.g.vscode == nil, -- disable all plugins when in vscode
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
			dependencies = {
				"tpope/vim-rhubarb",
			},
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
				{ "saghen/blink.cmp" },
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
			dependencies = {
				{ "kyazdani42/nvim-web-devicons", opt = true },
				"ThePrimeagen/harpoon",
			},
			config = function()
				local harpoon = require("harpoon")

				-- setup a function to jump to harpoon buffer when lualine clicked
				vim.cmd([[
					function! LualinePickHarpoon(tabnr, mouseclicks, mousebutton, modifiers)
						execute 'lua print("hej")'
						execute "lua require('harpoon'):list():select(" . a:tabnr . ")"
					endfunction
				]])

				function Harpoon_files()
					local contents = {}
					local marks_length = harpoon:list():length()
					local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")

					for i = 1, marks_length do
						local harpoon_file_path = harpoon:list():get(i).value

						local label = ""
						if vim.startswith(harpoon_file_path, "oil") then
							local dir_path = string.sub(harpoon_file_path, 7)
							dir_path = vim.fn.fnamemodify(dir_path, ":.")
							label = "[" .. dir_path .. "]"
						elseif harpoon_file_path ~= "" then
							label = vim.fn.fnamemodify(harpoon_file_path, ":t")
						end

						label = label ~= "" and label or "(empty)"
						-- call the function when the buffer is clicked. Magic
						label = string.format("%%%s@LualinePickHarpoon@%s%%T", i, label)

						if current_file_path == harpoon_file_path then
							contents[i] = string.format("%%#lualine_b_normal# %s. %%#lualine_b_normal#%s ", i, label)
						else
							contents[i] =
								string.format("%%#lualine_b_inactive# %s. %%#lualine_b_inactive#%s ", i, label)
						end
					end

					return table.concat(contents)
				end

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
						lualine_a = {},
						lualine_b = {
							{
								Harpoon_files,
								on_click = function(no_clicks, mouse_button, modifiers, bla)
									print("%s %s %s", no_clicks, mouse_button, modifiers, bla)
								end,
							},
						},
						lualine_y = {
							{
								"filename",
								path = 1,
							},
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
							local message =
								diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
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
				"echasnovski/mini.diff",
			},
			version = "*",
			config = function()
				require("codecompanion").setup({
					display = {
						diff = {
							enabled = true,
							provider = "mini_diff",
						},
					},
					strategies = {
						chat = {
							adapter = "copilot",
						},
						inline = {
							adapter = "copilot",
						},
						cmd = {
							adapter = "copilot",
						},
					},
					adapters = {
						openai = function()
							return require("codecompanion.adapters").extend("openai", {
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
					prompt_library = {
						["Repomix: File"] = {
							strategy = "chat",
							description = "Call AI based on repomix file",
							references = {
								{
									type = "file",
									path = {
										"repomix-output.txt",
									},
								},
							},
							prompts = {
								{
									role = "user",
									content = "You are working on a git repository. I've pasted the contents of relevant files of the repository.\n",
									opts = {
										auto_submit = false,
										user_prompt = true,
									},
								},
							},
						},
					},
				})

				vim.keymap.set({ "n", "v" }, "<leader>ac", ":CodeCompanionChat<cr>", { desc = "AI: Start new chat" })
				vim.keymap.set(
					{ "n", "v" },
					"<leader>at",
					":CodeCompanionChat Toggle<cr>",
					{ desc = "AI: Toggle chat" }
				)
				vim.keymap.set({ "n", "v" }, "<leader>aa", ":CodeCompanionActions <cr>", { desc = "AI: Show Actions" })
				vim.cmd([[cab cc CodeCompanion]])
			end,
		},
		{
			"github/copilot.vim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
			},
			version = "*",
			init = function()
				vim.g.copilot_no_tab_map = true
			end,
			config = function()
				vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
					expr = true,
					replace_keycodes = false,
				})
			end,
		},
	},
})

require("options")
require("mappings")
