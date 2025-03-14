---@param types string[] Will return the first node that matches one of these types
---@param node TSNode|nil
---@return TSNode|nil
local function find_node_ancestor(types, node)
	if not node then
		return nil
	end

	if vim.tbl_contains(types, node:type()) then
		return node
	end

	local parent = node:parent()

	return find_node_ancestor(types, parent)
end

-- If in a variable assignment (`err := fmt.Errorf()`) convert the `:=` to `=`
-- and vice versa. Useful when the variable is already assigned earlier in the
-- code
local function flip_variable_assignment()
	local function_node = find_node_ancestor(
		{ "assignment_statement", "short_var_declaration" },
		vim.treesitter.get_node({ ignore_injections = false })
	)

	if not function_node then
		print("Not in a variable assignment, exiting")
		return
	end

	local function_text = vim.treesitter.get_node_text(function_node, 0)
	local start_row = function_node:start()

	local assignment_operator, replace_with
	if function_node:type() == "assignment_statement" then
		assignment_operator = "="
		replace_with = ":="
	elseif function_node:type() == "short_var_declaration" then
		assignment_operator = ":="
		replace_with = "="
	else
		print("type was unknown")
		return
	end

	local start_col, end_col = function_text:find(assignment_operator)
	if not start_col or not end_col then
		print("Could not find equal sign")
		return
	end

	print(start_col, end_col)

	vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, end_col + 1, { replace_with })
end

-- runs `go mod tidy` from the buffer's directory
local function run_go_mod_tidy()
	local buffer_parent_folder = vim.fn.expand("%:h")
	local obj = vim.system({ "go", "mod", "tidy" }, {
		cwd = buffer_parent_folder,
	}):wait()
	if obj.code ~= 0 then
		error("failed to call go mod tidy: " .. (obj.stderr or ""), 1)
	end
	print("fininshed running go mod tidy on ", buffer_parent_folder)
end

vim.keymap.set({ "n" }, "<Leader>ne", flip_variable_assignment, { desc = "Go: Flip `=` and `:=`", buffer = true })
vim.keymap.set({ "n" }, "<Leader>nt", run_go_mod_tidy, { desc = "Go: Go mod tidy", buffer = true })
