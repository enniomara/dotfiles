local function restore_nvim_tree()
	local nvim_tree = require("nvim-tree")
	nvim_tree.change_dir(vim.fn.getcwd())
	nvim_tree.refresh()
end

require("auto-session").setup({
	pre_save_cmds = { "NvimTreeClose" },
})
