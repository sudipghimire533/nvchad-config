require "nvchad.mappings"

local M = {}

local map = vim.keymap.set
local unmap = vim.keymap.del

-- default mappings for everything
M.default_mappings = function()
    map("n", ";", ":", { desc = "CMD enter command mode" })

    -- bring clipboard history. I use diodon and xclip. Will bring popup at mouse pointer location
    map({ "n", "i", "v", "c", "t" }, "<C-v>", function()
        vim.fn.jobstart("diodon", { detach = false })
        vim.cmd "stopinsert"
    end, { desc = "Launch diodon" })
end

-- let's use some mouse
M.mouse_mappings = function() end

-- move that thing
M.navigation_mappings = function()
    local buf = require "nvchad.tabufline"
    local nav_with = function(key, cmd, doc)
        map("n", key, cmd, { desc = doc })
    end

    nav_with("<C-Tab>", ":tabnext<cr>", "goto next tabpage")
    nav_with("<C-S-Tab>", ":tabprevious<cr>", "goto next tabpage")
    nav_with("<Tab>", buf.next, "buffer goto next")
    nav_with("<S-Tab>", buf.prev, "buffer goto previous")
    unmap("n", "<C-h>")
    unmap("n", "<C-j>")
    unmap("n", "<C-k>")
    unmap("n", "<C-l>")
end

-- oh my telescope
M.telescope_mappings = function()
    local scope = function(key, cmd, doc)
        map("n", key, cmd, { desc = doc })
    end

    scope("<leader>fF", ":Telescope<CR>", "Telescope menu")
    scope("<leader>fk", ":Telescope keymaps<CR>", "telescope Show vim's mapped keys")
    scope("<leader>fw", ":Telescope live_grep<CR>", "telescope live grep")
    scope("<leader>fb", ":Telescope buffers<CR>", "telescope find buffers")
    scope("<leader>fh", ":Telescope help_tags<CR>", "telescope help page")
    scope("<leader>fma", ":Telescope marks<CR>", "telescope find marks")
    scope("<leader>fo", ":Telescope oldfiles<CR>", "telescope find oldfiles")
    scope("<leader>fz", ":Telescope current_buffer_fuzzy_find<CR>", "telescope find in current buffer")
    scope("<leader>fts", ":Telescope terms<CR>", "telescope pick hidden term")
    scope("<leader>fgs", ":Telescope git_status<CR>", "git status by telescope")
    scope("<leader>fgc", ":Telescope git_commits<CR>", "git commit by telescope")
    scope("<leader>fgb", ":Telescope git_commits<CR>", "git branches by telescope")
    scope("<leader>fpp", ":Telescope project<CR>", "Telescop project extensin")
    unmap("n", "<leader>gt") -- nvchad's version of <leader>fgs
    unmap("n", "<leader>cm") -- nvchad's version of <leader>fgc
    unmap("n", "<leader>ma") -- nvchad's version of <leader>fma
    unmap("n", "<leader>pt") -- nvchad's version of <leader>fts
end

-- terminal inside neovim
M.terminal_mappings = function()
    local term = require "nvchad.term"
    local new_terminal = function(mode, key, pos, desc)
        map(mode, key, function()
            term.new { pos = pos }
        end, { desc = desc })
    end
    local toggle_terminal = function(mode, key, pos, desc)
        map(mode, key, function()
            term.toggle { pos = pos, id = pos .. "toggleTerm" }
        end, { desc = desc })
    end

    toggle_terminal("n", "<leader>v", "vsp", "terminal toggleable vertical term")
    toggle_terminal("n", "<leader>h", "sp", "terminal toggleable horizontal term")
    toggle_terminal("n", "<A-i>", "float", "terminal toggle floating term")
    new_terminal("n", "<A-v>", "vsp", "terminal new vertical term")
    new_terminal("n", "<A-h>", "sp", "terminal new horizontal term")
    -- escape terminal
    map("t", "<Esc>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
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
    map("n", "<leader>K", vim.lsp.buf.hover, opts "Hover")

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

    map("n", "<leader>K", vim.cmd.RustLsp { "hover", "actions" }, opts "Hover")
end

M.apply_all = function()
    M.default_mappings()
    M.navigation_mappings()
    M.telescope_mappings()
    M.terminal_mappings()
end

return M
