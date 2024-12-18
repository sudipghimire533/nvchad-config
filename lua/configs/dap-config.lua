local dap = require "dap"

dap.adapters.lldb = {
    type = "executable",
    command = vim.env.HOME .. '/.local/share/nvim/mason/bin/codelldb',
    name = "codelldb",
}

