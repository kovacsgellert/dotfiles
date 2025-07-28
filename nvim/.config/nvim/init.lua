if vim.g.vscode then
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    require("vscode.keymaps")
else
    require("config.lazy")
end