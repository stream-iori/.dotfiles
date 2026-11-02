return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
    },
  },
}
