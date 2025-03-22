local configs = require "nvchad.configs.lspconfig"

local on_attach_redefeined = function(client, bufnr)
    configs.on_attach(client, bufnr)
    vim.lsp.inlay_hint.enable(true)
    require("mappings").init_lsp_mappings(bufnr)
end

local servers = {
    html = {},
    awk_ls = {},
    rust_analyzer = {
        on_init = configs.on_init,
        capabilities = configs.capabilities,
        on_attach = on_attach_redefeined,
        -- do_not_setup = {},
    },
    gopls = {},
    bashls = {},
    lua_ls = {
        on_init = function(client)
            configs.on_init(client)

            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                diagnostics = { globals = { "vim" } },
                runtime = { version = "LuaJIT" },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.fn.expand "$VIMRUNTIME/lua",
                        vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                        vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                        vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                        "${3rd}/luv/library",
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
            })
        end,
        settings = { Lua = {} },
    },
}

for name, opts in pairs(servers) do
    if not opts.on_init then
        opts.on_init = configs.on_init
    end
    if not opts.capabilities then
        opts.capabilities = configs.capabilities
    end
    if not opts.on_attach then
        opts.on_attach = on_attach_redefeined
    end
    if not opts.do_not_setup then
        require("lspconfig")[name].setup(opts)
    end
end

-- rust specific config for rustaceanvim
-- provides non-standard lsp features
local rustaceanvim = require "rustaceanvim"
rustaceanvim.configs = {
    server = servers.rust_analyzer,
    tools = {},
    dap = {},
}
