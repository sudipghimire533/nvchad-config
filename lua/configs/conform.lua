local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- rust = { "rustfmt" },
    },

    format_on_save = {
        lsp_fallback = true,
    },
}

return options
