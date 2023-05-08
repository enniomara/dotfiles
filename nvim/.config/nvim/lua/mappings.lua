-- Mapping helper
local mapper = function(mode, key, result)
	vim.keymap.set(mode, key, result, { noremap = true, silent = true })
end

mapper("n", "<Leader>qq", ":Bdelete<CR>") -- close current buffer
mapper("n", "<Leader>ff", ":Telescope find_files<CR>")
mapper("n", "<Leader>fg", ":Telescope live_grep<CR>")
mapper("n", "<Leader>fb", ":Telescope buffers<CR>")
mapper("n", "<Leader>f;", ":Telescope keymaps<CR>")
mapper("n", "<Leader>fs", ":Telescope sessions<CR>")
mapper("n", "<Leader>fp", ":Telescope<CR>")

mapper("n", "<C-k>", ":BufferLineCycleNext <CR>")
mapper("n", "<C-j>", ":BufferLineCyclePrev <CR>")
mapper("n", "]b", ":BufferLineCycleNext <CR>")
mapper("n", "[b", ":BufferLineCyclePrev <CR>")
mapper("n", "<Leader>bp", ":BufferLineTogglePin<CR>")
mapper("n", "<Leader>bP", ":BufferLineGroupClose ungrouped<CR>")

mapper("n", "<Leader>,z", ":Lazy<CR>")

-- easier movement to save buffer than :w
mapper("n", "<Leader>ss", ":silent write<CR>")
mapper("n", "<C-s>", ":silent write<CR>")

-- Tmux-zoom like feature, full-screens the current pane
mapper("n", "<C-W>z", ":tab split <CR>")

vim.keymap.set({ "n" }, "<Leader>gg", function()
	if vim.bo.filetype == "fugitive" then
		vim.cmd(":q")
	else
		vim.cmd("Git")
	end
end)
mapper("n", "<Leader>gcv", ":Git commit -v<CR>")

-- Make sure search result is in the middle of buffer
mapper("n", "n", "nzzzv")
mapper("n", "N", "Nzzzv")

mapper("n", "Q", "<nop>") -- disable entering to ex-mode

mapper("v", "<Leader>yy", ":OSCYankVisual<CR>")

mapper("n", "<Leader>ld", function() -- disable diagnostics on this buffer
	vim.diagnostic.disable(0)
end)
mapper("n", "<Leader>le", function() -- enable diagnostics on this buffer
	vim.diagnostic.enable(0)
end)

-- becusae : is in a horrible place to reach in qwerty
mapper({ "n", "v" }, "<Leader>jj", ":")
mapper({ "n", "v" }, "<Leader>jk", "/")
