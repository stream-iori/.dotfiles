local function python_path()
  local virtual_env = vim.env.VIRTUAL_ENV
  if virtual_env and virtual_env ~= "" then
    return vim.fs.joinpath(virtual_env, "bin", "python")
  end

  local root = LazyVim.root() or vim.uv.cwd()
  for _, folder in ipairs({ ".venv", "venv" }) do
    local candidate = vim.fs.joinpath(root, folder, "bin", "python")
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end
  return vim.fn.exepath("python3") ~= "" and "python3" or "python"
end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/nvim-nio",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
          python = python_path,
        },
      },
    },
  },
}
