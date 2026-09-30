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

-- Repository-relative, independent of :cd; fall back to the logical project root.
map("n", "<leader>fy", function()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    vim.notify("Current buffer has no file path", vim.log.levels.WARN)
    return
  end
  local root = vim.fs.root(vim.fs.dirname(name), ".git") or LazyVim.root()
  local path = vim.fs.relpath(root, name) or name
  vim.fn.setreg("+", path)
  vim.notify("Copied relative path: " .. path)
end, { desc = "Copy Relative Path" })
