vim.g.mapleader = " "

-- Needed so that packer knows how to load the treesitter grammars installed by
-- nix
vim.cmd([[packloadall ]])

---@type LazyConfig
local lazyConfig = {
	-- Problems with treesitter and nix, the dependencies for grammas were not
	-- loaded propery when resetting packpath and rtp
	performance = {
		reset_packpath = false,
		rtp = {
			reset = false,
		},
	},
	change_detection = {
		enabled = false,
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
			-- the command is commented because treesitter is managed by nix
			-- build = ":TsUpdate",
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
				{ "saghen/blink.cmp" },
			},
			config = function()
				require("config.lsp")
			end,
			event = { "BufReadPre", "BufNewFile" },
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
							"searchcount", -- show [12/18] when searching
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
			"olimorris/codecompanion.nvim",
			event = "VeryLazy",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"j-hui/fidget.nvim",
				{
					"ravitemer/codecompanion-history.nvim",
					version = "*",
				},
				{
					"nvimtools/none-ls.nvim",
				},
			},
			version = "*",
			init = function()
				require("plugins.codecompanion.fidget-spinner"):init()
			end,
			config = function()
				require("codecompanion").setup({
					interactions = {
						chat = {
							adapter = "copilot",
							slash_commands = {
								["buffer"] = {
									keymaps = {
										modes = {
											i = "<C-b>",
										},
									},
								},
								["file"] = {
									keymaps = {
										modes = {
											i = "<C-f>",
										},
									},
								},
							},
						},
						inline = {
							adapter = "copilot",
						},
						cmd = {
							adapter = "copilot",
						},
					},
					prompt_library = {
						["Edit buffer"] = {
							strategy = "chat",
							description = "Edit the current buffer with AI",
							opts = {
								alias = "buffer",
								auto_submit = false,
							},
							prompts = {
								{
									role = "user",
									content = "#{buffer}{diff} @insert_edit_into_file ",
									opts = {},
								},
							},
						},
					},
					extensions = {
						history = {
							enabled = true,
						},
					},
				})

				vim.keymap.set({ "n", "v" }, "<leader>ac", ":CodeCompanionChat<cr>", { desc = "AI: Start new chat" })
				vim.keymap.set({ "n" }, "<leader>ab", function()
					require("codecompanion").prompt("buffer")
				end, { desc = "AI: Edit current buffer" })
				vim.keymap.set(
					{ "n", "v" },
					"<leader>ai",
					":CodeCompanionChat Toggle<cr>",
					{ desc = "AI: Toggle chat" }
				)
				vim.keymap.set({ "n", "v" }, "<leader>aa", ":CodeCompanionActions <cr>", { desc = "AI: Show Actions" })
				vim.keymap.set({ "n", "v" }, "<M-S-k>", ":CodeCompanion ", { desc = "AI: Edit" })
				vim.cmd([[cab cc CodeCompanion]])

				local null_ls = require("null-ls")
				null_ls.register({
					name = "CodeCompanion",
					method = null_ls.methods.CODE_ACTION,
					filetypes = {},
					generator = {
						fn = function(_)
							local actions = require("codecompanion.actions")
							local context = require("codecompanion.utils.context")

							local current_context = context.get(vim.api.nvim_get_current_buf(), {})
							local actions_list = actions.items(current_context)

							local diagnostics = {}
							for _, action in ipairs(actions_list) do
								table.insert(diagnostics, {
									title = action.name,
									action = function()
										actions.resolve(action, current_context)
									end,
								})
							end
							return diagnostics
						end,
					},
				})
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
				vim.keymap.set("n", "<leader>ade", function()
					vim.cmd("Copilot enable")
					vim.notify("Copilot enabled", vim.log.levels.INFO)
				end, {
					desc = "AI: (E)nable Copilot",
				})
				vim.keymap.set("n", "<leader>add", function()
					vim.cmd("Copilot disable")
					vim.notify("Copilot disabled", vim.log.levels.INFO)
				end, {
					desc = "AI: (D)isable Copilot",
				})
			end,
		},
		{
			"pwntester/octo.nvim",
			cmd = { "Octo" },
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"nvim-tree/nvim-web-devicons",
			},
			opts = {},
		},
	},
}
require("lazy").setup(lazyConfig)

require("options")
require("mappings")
