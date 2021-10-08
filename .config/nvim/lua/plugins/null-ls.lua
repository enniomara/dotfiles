local b = require('null-ls').builtins
local sources = {
   -- Lua
   b.formatting.stylua,

   -- Shell
   b.formatting.shfmt,
}

require('null-ls').config({
    sources = sources,
})
