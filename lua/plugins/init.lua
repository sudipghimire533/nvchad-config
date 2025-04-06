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
}
