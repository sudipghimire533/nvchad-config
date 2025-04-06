require "nvchad.options"

-- do not show invisible chars ( example: $ at end of line )
vim.opt.list = false
-- relative number makes it easy to navigate
vim.wo.relativenumber = true

-- neovide config
if vim.g.neovide then
    require "neovide"
end
