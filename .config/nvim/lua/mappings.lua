-- Mapping helper
local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

mapper("n", "<Leader>d", ":NvimTreeToggle<CR>")
