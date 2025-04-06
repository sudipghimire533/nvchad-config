require "nvchad.options"

-- :checkhealth floating in sky
vim.g.health = { style = "float" }

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- do not show invisible chars ( example: $ at end of line )
vim.opt.list = false
-- relative number makes it easy to navigate
vim.wo.relativenumber = true

-- enable mouse
vim.o.mouse = "a"

-- neovide config
if vim.g.neovide then
    require "neovide"
end
