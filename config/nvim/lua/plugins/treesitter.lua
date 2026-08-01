return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local parsers = {}
    local seen = {}
    for _, parser in ipairs(opts.ensure_installed or {}) do
      if not seen[parser] then
        seen[parser] = true
        parsers[#parsers + 1] = parser
      end
    end
    if not seen.java then
      parsers[#parsers + 1] = "java"
    end
    opts.ensure_installed = parsers
  end,
}
