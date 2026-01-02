--- neovide
if vim.g.neovide then
  vim.o.guifont = "Maple Mono NF CN:h15"
end
-- bootstrap lazy.nvim, LazyVim and your plusins
require("config.lazy")
