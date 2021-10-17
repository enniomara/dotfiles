-- Mapping helper
local mapper = function(mode, key, result)
	vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end

mapper("n", "<Leader>d", ":NvimTreeToggle<CR>")
mapper("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>")
mapper("n", "<Leader>fd", "<cmd>lua require('telescope.builtin').file_browser()<CR>")
mapper("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
mapper("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
mapper("n", "<Leader>fs", ":Telescope sessions<CR>")

mapper("n", "gb", ":BufferLinePick<CR>")
mapper("n", "<Tab>", ":BufferLineCycleNext <CR>")
mapper("n", "<S-Tab>", ":BufferLineCyclePrev <CR>")
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

-- Tmux-zoom like feature, full-screens the current pane
mapper("n", "<C-W>z", ":tab split <CR>")
