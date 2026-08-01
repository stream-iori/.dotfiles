return {
  {
    "julienvincent/nvim-paredit",
    ft = { "clojure", "fennel", "scheme", "lisp", "janet" },
    opts = function(_, opts)
      local paredit = require("nvim-paredit")
      opts.use_default_keys = false
      opts.filetypes = { "clojure", "fennel", "scheme", "lisp", "janet" }
      opts.keys = {
        ["<localleader>ps"] = { paredit.api.slurp_forwards, "Slurp forwards" },
        ["<localleader>pS"] = { paredit.api.slurp_backwards, "Slurp backwards" },
        ["<localleader>pb"] = { paredit.api.barf_forwards, "Barf forwards" },
        ["<localleader>pB"] = { paredit.api.barf_backwards, "Barf backwards" },
        ["<localleader>pr"] = { paredit.api.raise_form, "Raise form" },
        ["<localleader>px"] = { paredit.unwrap.unwrap_form_under_cursor, "Splice form" },
        ["<localleader>p]"] = { paredit.api.drag_element_forwards, "Drag element forwards" },
        ["<localleader>p["] = { paredit.api.drag_element_backwards, "Drag element backwards" },
        af = {
          paredit.api.select_around_form,
          "Around form",
          repeatable = false,
          mode = { "o", "x" },
        },
        ["if"] = {
          paredit.api.select_in_form,
          "In form",
          repeatable = false,
          mode = { "o", "x" },
        },
      }
    end,
  },
  {
    "Olical/conjure",
    ft = { "clojure", "fennel" },
    init = function()
      vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = 1
      vim.g["conjure#mapping#doc_word"] = "K"
      vim.g["conjure#mapping#def_word"] = "gd"
    end,
    config = function()
      require("conjure.main").main()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "clojure" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clojure_lsp = {},
      },
    },
  },
}
