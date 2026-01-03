--- neovide
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMonoNL Nerd Font Mono:h16"
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 1. - 1
  vim.g.neovide_floating_blur_amount_y = 1.0
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"

  -- key mapping
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

-- bootstrap lazy.nvim, LazyVim and your plusins
require("config.lazy")
