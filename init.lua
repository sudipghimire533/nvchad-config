-- <leader> is now <space>. And I call it space leader
vim.g.mapleader = " "

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- load plugins
local lazy_config = require "configs.lazy"
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
    },

    { import = "plugins" },
}, lazy_config)

require "options"
require "nvchad.autocmds"

vim.schedule(function()
    require("mappings").apply_all()
end)
