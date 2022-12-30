-- Mapping helper
local mapper = function(mode, key, result)
	vim.keymap.set(mode, key, result, { noremap = true, silent = true })
end

mapper("n", "<Leader>d", ":Neotree toggle=true<CR>")
mapper("n", "<Leader>qq", ":Bdelete<CR>") -- close current buffer
mapper("n", "<Leader>ff", ":Telescope find_files<CR>")
mapper("n", "<Leader>fg", ":Telescope live_grep<CR>")
mapper("n", "<Leader>fb", ":Telescope buffers<CR>")
mapper("n", "<Leader>f;", ":Telescope commands<CR>")
mapper("n", "<Leader>fs", ":Telescope sessions<CR>")
mapper("n", "<Leader>fp", ":Telescope<CR>")

mapper("n", "gb", ":BufferLinePick<CR>")
mapper("n", "<C-k>", ":BufferLineCycleNext <CR>")
mapper("n", "<C-j>", ":BufferLineCyclePrev <CR>")
mapper("n", "]b", ":BufferLineCycleNext <CR>")
mapper("n", "[b", ":BufferLineCyclePrev <CR>")
mapper("n", "<Leader>1", ":BufferLineGoToBuffer 1<CR>")
mapper("n", "<Leader>2", ":BufferLineGoToBuffer 2<CR>")
mapper("n", "<Leader>3", ":BufferLineGoToBuffer 3<CR>")
mapper("n", "<Leader>4", ":BufferLineGoToBuffer 4<CR>")
mapper("n", "<Leader>5", ":BufferLineGoToBuffer 5<CR>")
mapper("n", "<Leader>5", ":BufferLineGoToBuffer 6<CR>")
mapper("n", "<Leader>5", ":BufferLineGoToBuffer 7<CR>")
mapper("n", "<Leader>5", ":BufferLineGoToBuffer 8<CR>")
mapper("n", "<Leader>5", ":BufferLineGoToBuffer 5<CR>")

-- easier movement to save buffer than :w
mapper("n", "<Leader>ss", ":w<CR>")
mapper("n", "<C-s>", ":w<CR>")

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

mapper("v", "<Leader>yy", ":OSCYank<CR>")

mapper("n", "<Leader>ld", ":lua vim.diagnostic.disable(0)<CR>") -- disable diagnostics on this buffer
mapper("n", "<Leader>le", ":lua vim.diagnostic.enable(0)<CR>") -- enable diagnostics on this buffer
