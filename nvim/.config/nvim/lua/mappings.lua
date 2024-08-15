vim.keymap.set("n", "<Leader>qq", ":Bdelete<CR>") -- close current buffer
vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", { desc = "Fuzzy find" })
vim.keymap.set("n", "<Leader>fG", ":Telescope dir live_grep<CR>", { desc = "Fuzzy find in directory" })
vim.keymap.set("n", "<Leader>fb", ":Telescope buffers<CR>", { desc = "Find buffer" })
vim.keymap.set("n", "<Leader>f;", ":Telescope keymaps<CR>", { desc = "Find keymaps" })
vim.keymap.set("n", "<Leader>fp", ":Telescope<CR>")

vim.keymap.set("n", "<C-k>", ":bnext <CR>")
vim.keymap.set("n", "<C-j>", ":bprev <CR>")

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
end, {desc = "Git: Open Fugitive"})
vim.keymap.set("n", "<Leader>gcv", ":Git commit -v<CR>", {desc = "Git: Commit"})

-- Make sure search result is in the middle of buffer
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "<nop>") -- disable entering to ex-mode

vim.keymap.set("n", "<Leader>ld", function() -- disable diagnostics on this buffer
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, {desc = "LSP: Toggle diagnostics"})
vim.keymap.set("n", "<Leader>lh", function() -- Toggle inlay hints
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {desc = "LSP: Toggle inlay hints"})

-- becusae : is in a horrible place to reach in qwerty
vim.keymap.set({ "n", "v" }, "<Leader>jj", ":")
vim.keymap.set({ "n", "v" }, "<Leader>jk", "/")
