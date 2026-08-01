--- neovide
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMonoNL Nerd Font Mono:h16"
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 1.0
  vim.g.neovide_floating_blur_amount_y = 1.0
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"

  local map = vim.keymap.set
  local function paste_clipboard()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end

  map("n", "<D-s>", "<cmd>write<cr>", { desc = "Save File" })
  map("x", "<D-c>", '"+y', { desc = "Copy to System Clipboard" })
  map("n", "<D-v>", '"+p', { desc = "Paste from System Clipboard" })
  map("x", "<D-v>", '"+P', { desc = "Paste from System Clipboard" })
  map({ "i", "c", "t" }, "<D-v>", paste_clipboard, { desc = "Paste from System Clipboard" })
end

-- bootstrap lazy.nvim, LazyVim and your plusins
require("config.lazy")
