local lspconfig = require "configs.lspconfig"

return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = require "configs.conform",
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            return lspconfig
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
                "java",
                "rust",
                "toml",
                "typescript",
                "markdown",
                "go",
                "gomod",
                "gosum",
            },
        },
    },

    -- rust
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false, -- This plugin is already lazy
    },

    -- debugger
    {
        "mfussenegger/nvim-dap",
        config = function()
            require "configs.dap-config"
        end,
    },

    -- more telescope stuff
    {
        "nvim-telescope/telescope-project.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },

    -- dashboard
    {
        "goolord/alpha-nvim",
        priority = 2000,
        lazy = false,
        config = require "configs.dashboard",
    },

    -- for typescript
    {
        "typescript-language-server/typescript-language-server",
    },

    -- let's try go
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
}
