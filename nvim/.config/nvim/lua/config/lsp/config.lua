local M = {}

M.on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to Declaration" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to Implementation" })
	vim.keymap.set(
		"n",
		"<leader>wa",
		vim.lsp.buf.add_workspace_folder,
		{ buffer = bufnr, desc = "Add Workspace Folder" }
	)
	vim.keymap.set(
		"n",
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		{ buffer = bufnr, desc = "Remove Workspace Folder" }
	)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { buffer = bufnr, desc = "List Workspace Folders" })
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
	-- vim.keymap.set("v", "<leader>ca", vim.lsp.buf.range_code_action, { buffer = bufnr, desc = "Range Code Action" })
	vim.keymap.set("n", "<leader>e", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, { buffer = bufnr, desc = "Open Diagnostic Float" })
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = bufnr, desc = "Set Location List" })
	vim.keymap.set("n", "<leader>fm", function()
		vim.lsp.buf.format({ async = true })
	end, { buffer = bufnr, desc = "Format Code" })
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, {
			bufnr = bufnr,
		})
	end
end

return M
