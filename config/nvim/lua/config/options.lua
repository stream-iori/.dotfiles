-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opt = vim.opt

--禁用相当行号
opt.relativenumber = false
-- 代码默认不自动换行；文档类文件在 autocmds.lua 中按文件类型开启
opt.wrap = false
-- 避免隐藏一些字体
opt.conceallevel = 0

-- 隐藏标签栏 (Hide tabline)
opt.showtabline = 0

-- system clipboard
opt.clipboard = "unnamedplus"
