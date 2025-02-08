-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
local map = vim.keymap.set

-- format
map({ "n", "v" }, "<leader>fm", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- locate file
map({ "n", "v" }, "<leader><leader>e", ":Neotree reveal<CR>", { noremap = true, silent = true })
map({ "n", "v" }, "<leader>gp", ":Neotree reveal<CR>", { noremap = true, silent = true })
