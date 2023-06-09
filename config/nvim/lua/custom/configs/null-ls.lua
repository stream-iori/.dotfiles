local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with {
    filetypes = { "json", "html", "markdown", "css" }, -- so prettier works only on these filetypes
  },
  b.diagnostics.jsonlint.with { filetypes = { "json" } },

  -- Lua
  b.formatting.stylua,

  --c && cpp
  b.formatting.clang_format,

  -- golang
  b.formatting.gofumpt,
  b.formatting.goimports_reviser,
  b.formatting.golines,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
