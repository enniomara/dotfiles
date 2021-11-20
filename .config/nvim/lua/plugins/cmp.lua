-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({ with_text = false, maxwidth = 70 }),
	},
	mapping = {
		["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i" }),
		["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
		["<C-e>"] = cmp.mapping(cmp.mapping.close(), { "i" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "omni" },
	},
})

require("nvim-autopairs.completion.cmp").setup({
	map_cr = true, --  map <CR> on insert mode
	map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
	auto_select = true, -- automatically select the first item
	insert = false, -- use insert confirm behavior instead of replace
	map_char = { -- modifies the function or method delimiter by filetypes
		all = "(",
		tex = "{",
	},
})
