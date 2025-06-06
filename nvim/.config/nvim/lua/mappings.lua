--- VSCode aware function to create the rhs for a keymap. If neovim is running
--- inside vscode then the vscode_action will be called inside vscode.
---@param nvim_rhs function|string
---@param vscode_action string
---@return function|string
local function vs_rhs(nvim_rhs, vscode_action)
	if vim.g.vscode then
		return function()
			require("vscode").action(vscode_action)
		end
	else
		return nvim_rhs
	end
end

vim.keymap.set("n", "<Leader>qq", vs_rhs(":Bdelete<CR>", "workbench.action.closeActiveEditor")) -- close current buffer
vim.keymap.set(
	"n",
	"<Leader>ff",
	vs_rhs(":Telescope find_files<CR>", "workbench.action.quickOpen"),
	{ desc = "Find: Files" }
)
vim.keymap.set("n", "<Leader>fF", ":Telescope dir find_files<CR>", { desc = "Find: Files in directory" })
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", { desc = "Find: Fuzzy find" })
vim.keymap.set("n", "<Leader>fG", ":Telescope dir live_grep<CR>", { desc = "Find: Fuzzy find in directory" })
vim.keymap.set("n", "<Leader>fb", ":Telescope buffers<CR>", { desc = "Find: Buffer" })
vim.keymap.set("n", "<Leader>f;", ":Telescope keymaps<CR>", { desc = "Find: Keymaps" })
vim.keymap.set("n", "<Leader>fr", ":Telescope resume<CR>", { desc = "Find: Resume last search" })
vim.keymap.set("n", "<Leader>fp", ":Telescope<CR>", { desc = "Find: Telescope Commands" })

vim.keymap.set("n", "<Leader>,z", ":Lazy<CR>")

-- easier movement to save buffer than :w
vim.keymap.set("n", "<Leader>ss", ":silent write<CR>")
vim.keymap.set("n", "<C-s>", ":silent write<CR>")

-- Tmux-zoom like feature, full-screens the current pane
vim.keymap.set("n", "<C-W>z", ":tab split <CR>", { desc = "Zen mode (full screen current pane)" })

vim.keymap.set({ "n" }, "<Leader>gg", function()
	if vim.bo.filetype == "fugitive" then
		vim.cmd(":q")
	else
		vim.cmd("Git")
	end
end, { desc = "Git: Open Fugitive" })
vim.keymap.set("n", "<Leader>gcv", ":Git commit -v<CR>", { desc = "Git: Commit" })

-- Make sure search result is in the middle of buffer
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "<nop>") -- disable entering to ex-mode

vim.keymap.set("n", "<Leader>ld", function() -- disable diagnostics on this buffer
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "LSP: Toggle diagnostics" })
vim.keymap.set("n", "<Leader>lh", function() -- Toggle inlay hints
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "LSP: Toggle inlay hints" })

-- becusae : is in a horrible place to reach in qwerty
vim.keymap.set({ "n", "v" }, "<Leader>jj", ":")
vim.keymap.set({ "n", "v" }, "<Leader>jk", "/")

vim.keymap.set("c", "<m-d>", "<c-r>=expand('%:h')<cr>", { desc = "Insert current file's parent directory" })

-- VSCode specific keymaps
if vim.g.vscode then
	vim.keymap.set({ "n", "v" }, "<Leader>dd", function()
		require("vscode").action("workbench.action.toggleSidebarVisibility")
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>ca", function()
		require("vscode").action("editor.action.quickFix")
	end)
end

if not vim.g.vscode then
	vim.keymap.set({ "n", "s" }, "<esc>", function()
		vim.snippet.stop()
		local luasnip = require("luasnip")

		-- Adds an escape hatch to an annoying behaviour where LSP suggestions stop
		-- working if a snippet is active. Sometimes I use the iferr snippet, and
		-- then edit the body of the if statement. When that happens the snippet is
		-- still active, breaking suggestions.
		if luasnip:in_snippet() == true then
			luasnip:unlink_current()
			vim.notify("Snippet was unliked", vim.log.levels.INFO)
		end

		return "<esc>"
	end, { expr = true, desc = "Escape and clear hlsearch/snippet" })
end
