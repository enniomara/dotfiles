local indent = 4

vim.opt.expandtab = true -- Expand tab characters to space characters.
vim.opt.shiftwidth= indent -- One tab is now 4 spaces.
vim.opt.shiftround = true -- Always round up to the nearest tab.
vim.opt.tabstop= indent -- This one is also needed to achieve the desired effect.
vim.opt.softtabstop = indent -- Enables easy removal of an indentation level.
