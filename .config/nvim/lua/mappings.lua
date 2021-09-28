-- Mapping helper
local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

mapper("n", "<Leader>d", ":NvimTreeToggle<CR>")
mapper("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>")
mapper("n", "<Leader>fd", "<cmd>lua require('telescope.builtin').file_browser()<CR>")
mapper("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
