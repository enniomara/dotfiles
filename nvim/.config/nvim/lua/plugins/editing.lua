-- everything which has to do with code editing
--
return {
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
			require("config.cmp")
		end,
	},
	"rafamadriz/friendly-snippets",
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
}
