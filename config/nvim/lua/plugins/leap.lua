return {
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      {
        "s",
        function()
          require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
        end,
        mode = { "n", "x", "o" },
        desc = "Leap Bidirectional",
      },
      { "gs", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
    end,
  },
  -- Disable flash.nvim as it conflicts with leap
  { "folke/flash.nvim", enabled = false },
  -- Configure flit.nvim for enhanced f/t motions
  {
    "ggandor/flit.nvim",
    keys = function()
      ---@type LazyKeysSpec[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
}
