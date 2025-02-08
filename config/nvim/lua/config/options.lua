-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opt = vim.opt

--禁用相当行号
opt.relativenumber = false
-- 开启自动换行
opt.wrap = true
-- 避免隐藏一些字体
opt.conceallevel = 0
