local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- for rust fallback to lsp
        -- rust = { "rustfmt" },
    },

    format_on_save = {
        lsp_fallback = true,
    },
}

return options
