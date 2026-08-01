-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
local map = vim.keymap.set

-- copy relative path
map("n", "<leader>fy", function()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    vim.notify("Current buffer has no file path", vim.log.levels.WARN)
    return
  end
  local path = vim.fn.fnamemodify(name, ":.")
  vim.fn.setreg("+", path)
  vim.notify("Copied relative path: " .. path)
end, { desc = "Copy Relative Path" })
