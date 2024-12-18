require "nvchad.mappings"

local M = {}

local map = vim.keymap.set

-- default mappings for everythign
M.default_mappings = function()
    map("n", ";", ":", { desc = "CMD enter command mode" })
end

-- mappings enabled if some lsp server is attached
M.init_lsp_mappings = function(bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
    map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")
    map("n", "<leader>hh", vim.lsp.buf.hover, opts "Hover")

    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("n", "gr", vim.lsp.buf.references, opts "Show references")

    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")

    map("n", "<leader>tS", function()
        vim.lsp.buf.typehierarchy "supertypes"
    end, opts "See super types")

    map("n", "<leader>ts", function()
        vim.lsp.buf.typehierarchy "subtypes"
    end, opts "See sub types")
end

-- mappings ( & overrides for lsp ) if rusteacen is enabled
M.overrides_for_rustacean = function(bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "<leader>hh", vim.lsp.buf.hover, opts "Hover")
end

return M
