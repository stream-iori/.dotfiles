-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Enable English spell checking in Markdown while ignoring CJK text.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us", "cjk" }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable soft wrapping for prose buffers",
  group = vim.api.nvim_create_augroup("prose-options", { clear = true }),
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})

local java_editorconfig = vim.api.nvim_create_augroup("java-editorconfig-save", { clear = true })

local function restore_java_autoformat(buffer)
  local saved = buffer.java_autoformat_before_save
  if saved then
    buffer.autoformat = saved.enabled
    buffer.java_autoformat_before_save = nil
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Use EditorConfig rules for Java saves",
  group = java_editorconfig,
  pattern = "*.java",
  callback = function(event)
    local buffer = vim.b[event.buf]
    restore_java_autoformat(buffer)
    local rules = buffer.editorconfig
    if type(rules) ~= "table" then
      return
    end
    if not vim.iter(vim.tbl_keys(rules)):any(function(property)
      return property ~= "root"
    end) then
      return
    end

    local autoformat = buffer.autoformat
    if autoformat == false then
      return
    end

    -- This runs before LazyFormat, which reads the buffer's autoformat setting.
    buffer.java_autoformat_before_save = { enabled = autoformat }
    buffer.autoformat = false
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Restore Java buffer formatting after save",
  group = java_editorconfig,
  pattern = "*.java",
  callback = function(event)
    restore_java_autoformat(vim.b[event.buf])
  end,
})
