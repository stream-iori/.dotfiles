-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
local map = vim.keymap.set

-- Use the jump list for all everyday navigation returns, including LSP jumps.
map("n", "<C-t>", "<C-o>", { desc = "Back to Previous Location" })

local selection = require("config.text-selection")
map("n", "S", selection.expand, { desc = "Expand Structural Selection" })
map({ "n", "x" }, "<C-Space>", selection.expand, { desc = "Expand Structural Selection" })
map("x", "<BS>", selection.shrink, { desc = "Shrink Structural Selection" })

local reference = require("config.copy-reference")
map("n", "<leader>fy", reference.copy_symbol, { desc = "Copy Reference" })
map("n", "<leader>fY", reference.copy_path, { desc = "Copy Relative Path" })
