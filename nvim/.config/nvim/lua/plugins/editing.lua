-- everything which has to do with code editing
--
return {
	{
		-- TODO: Add cmdline supoprt when that is added in blink.cmp
		"saghen/blink.cmp",
		version = "*",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			'rafamadriz/friendly-snippets',
			{
				'L3MON4D3/LuaSnip',
				version = "*",
			},
		},
		opts = {
			keymap = {
				preset = 'enter',
				['<Tab>'] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_next()
						end
					end,
					'snippet_forward', 'fallback' },
				['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				ghost_text = {
					enabled = true,
				},
				trigger = {
					-- no completion when we are in snippet. I use tab to
					-- advance in the snippet, and tab to scroll through
					-- completion
					show_in_snippet = false,
				},
				menu = {
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
					},
				},
			},
			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = 'mono'
			},
			sources = {
				default = { 'lsp', "luasnip", 'path', 'snippets', 'buffer' },
			},
			snippets = {
				expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
				active = function(filter)
					if filter and filter.direction then
						return require('luasnip').jumpable(filter.direction)
					end
					return require('luasnip').in_snippet()
				end,
				jump = function(direction) require('luasnip').jump(direction) end,
			},
		},
	},
	{
		"folke/which-key.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({})

			local opts = { nowait = false, remap = false }
			wk.add({
				{ "<leader>g", group = "Git",     unpack(opts) },
				{ "<leader>t", group = "Test",    unpack(opts) },
				{ "<leader>d", group = "Debug",   unpack(opts) },
				{ "<leader>f", group = "Find",    unpack(opts) },
				{ "<leader>k", group = "Harpoon", unpack(opts) },
				{ "<leader>l", group = "LSP",     unpack(opts) },
				{ "<leader>a", group = "AI",      unpack(opts) },
			})
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
		"ntpeters/vim-better-whitespace",
		config = function()
			require("config.vim-better-whitespace")
		end,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").create_default_mappings()
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		version = "*",
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
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			local harpoon = require("harpoon")

			-- basic telescope configuration
			--  from https://github.com/ThePrimeagen/harpoon/tree/harpoon2?tab=readme-ov-file#telescope
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers").new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				}):find()
			end

			vim.keymap.set("n", "<leader>fh", function() toggle_telescope(harpoon:list()) end,
				{ desc = "File: Harpoon" })

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

			vim.keymap.set("n", "<M-'>", function()
				harpoon:list():select(5)
			end)

			vim.keymap.set("n", "<M-\\>", function()
				harpoon:list():select(6)
			end)

			vim.keymap.set("n", "<M-m>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<M-,>", function()
				harpoon:list():next()
			end)
		end,
	},
}
