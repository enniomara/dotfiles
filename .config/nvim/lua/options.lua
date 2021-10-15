local indent = 4
vim.g.mapleader = " "

vim.opt.autoread = true
vim.opt.expandtab = true -- Expand tab characters to space characters.
vim.opt.shiftwidth = indent -- One tab is now 4 spaces.
vim.opt.shiftround = true -- Always round up to the nearest tab.
vim.opt.tabstop = indent -- This one is also needed to achieve the desired effect.
vim.opt.softtabstop = indent -- Enables easy removal of an indentation level.

vim.opt.autoindent = true -- Automatically copy the previous indent level. Don't use smartindent!!!
-- vim.opt.backspace = 2 -- Used for making backspace work like in most other editors (e.g. removing a single indent).
vim.opt.wrap = true -- Wrap text. This is also quite optional, replace with textwidth=80 is you don't want this behaviour.
vim.opt.lazyredraw = true -- Good performance boost when executing macros, redraw the screen only on certain commands.

vim.opt.ignorecase = true --- Search is not case sensitive, which is usually what we want.
vim.opt.incsearch = true -- Enables the user to step through each search 'hit', usually what is desired here.
vim.opt.hlsearch = true -- Will stop highlighting current search 'hits' when another search is performed.

vim.opt.scrolloff = 10 -- The screen will only scroll when the cursor is 8 characters from the top/bottom.
vim.opt.wildmenu = true -- Enable the 'autocomplete' menu when in command mode (':').
vim.opt.wildmode = { "longest:full", "full" } -- Autocomplete til the longest word and don't fill it. Fixes annoying behaviour of vim

vim.opt.number = true -- Show line numbers on left side
vim.opt.foldcolumn = "1" -- Add a bit extra margin to the left

vim.opt.laststatus = 2 -- Always show statusline
vim.opt.updatetime = 500 -- Set this to 500 milliseconds so that git gutter can update the gutter

vim.opt.mouse = "a"
vim.opt.confirm = true -- Make vim confirm of file should be saved when exiting

vim.opt.syntax = "on"

vim.g.nord_borders = true
vim.cmd([[colorscheme nord]])

vim.opt.termguicolors = true

-- Due to a bug in telescope, folding will not be applied automatically so a
-- `zx` needs to be ran in order to recompute folds.
-- See https://github.com/nvim-telescope/telescope.nvim/issues/699
vim.opt.foldenable = false -- I don't want to fold by default
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.timeoutlen = 500 -- more reasonalble default (and to make which-key show result faster)
vim.opt.cursorline = true
