-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- format
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set
map({ "n", "v" }, "<leader>fm", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- lsp
vim.keymap.set("n", "ge", vim.diagnostic.open_float)
