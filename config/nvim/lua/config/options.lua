-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opt = vim.opt

-- enable blink
vim.g.lazyvim_blink_main = true

--禁用相当行号
opt.relativenumber = false
-- 开启自动换行
opt.wrap = true
-- 避免隐藏一些字体
opt.conceallevel = 0

-- 隐藏标签栏 (Hide tabline)
opt.showtabline = 0

-- system clipboard
vim.opt.clipboard = "unnamedplus"

