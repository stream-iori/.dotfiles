---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  i = {
    -- save on insert mode
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
  },
}

M.lspconfig = {}

-- more keybinds

return M
