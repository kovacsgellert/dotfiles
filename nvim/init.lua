-- Set up smart case searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

if vim.g.vscode then
    -- VSCode Neovim
    require "user.vscode_keymaps"
else
    -- Ordinary Neovim
end