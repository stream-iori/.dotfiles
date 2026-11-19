vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = -1
vim.opt_local.tabstop = 4

local reset = "setlocal expandtab< shiftwidth< softtabstop< tabstop<"
vim.b.undo_ftplugin = vim.b.undo_ftplugin and (vim.b.undo_ftplugin .. " | " .. reset) or reset
