---@type MappingsTable
local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
    -- i will use for diagnostic
      ["ge"] = "",
      ["gn"] = ""
  }
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  i = {
    -- save on insert mode
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
  },
}

M.lspconfig = {
  n = {
    ["gn"] = {"<cmd>lua vim.diagnostic.goto_next()<CR>"},
    ["ge"] = {"<cmd>lua vim.diagnostic.goto_prev()<CR>"}
  }
}

-- debug
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last()
      end,
      "Debug last go test",
    },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags",
    },
  },
}

return M
