local runtime_names = {
  [8] = "JavaSE-1.8",
  [17] = "JavaSE-17",
  [25] = "JavaSE-25",
}

local function jdk_version(home)
  if vim.fn.executable(vim.fs.joinpath(home, "bin", "java")) ~= 1 then
    return
  end

  local ok, release = pcall(vim.fn.readfile, vim.fs.joinpath(home, "release"))
  if not ok then
    return
  end

  for _, line in ipairs(release) do
    local version = line:match('^JAVA_VERSION="(%d[%d._]*)')
    if version then
      version = version:gsub("^1%.", "")
      return vim.tbl_map(tonumber, vim.split(version, "[._]"))
    end
  end
end

local function prefer_jdk(candidate, selected)
  if candidate.active ~= selected.active then
    return candidate.active
  end

  for index = 1, math.max(#candidate.version, #selected.version) do
    local installed = candidate.version[index] or 0
    local previous = selected.version[index] or 0
    if installed ~= previous then
      return installed > previous
    end
  end
  return candidate.home > selected.home
end

local function sdkman_jdks()
  local sdkman_dir = vim.env.SDKMAN_DIR or vim.fn.expand("~/.sdkman")
  local candidates = vim.env.SDKMAN_CANDIDATES_DIR or vim.fs.joinpath(sdkman_dir, "candidates")
  local java_dir = vim.fs.joinpath(candidates, "java")
  local active_home = vim.uv.fs_realpath(vim.env.JAVA_HOME or vim.fs.joinpath(java_dir, "current"))
  local jdks = {}

  for name in vim.fs.dir(java_dir) do
    if name ~= "current" then
      local home = vim.fs.joinpath(java_dir, name)
      local version = jdk_version(home)
      local major = version and version[1]
      if major and runtime_names[major] then
        local candidate = {
          home = home,
          version = version,
          active = active_home ~= nil and vim.uv.fs_realpath(home) == active_home,
        }
        if not jdks[major] or prefer_jdk(candidate, jdks[major]) then
          jdks[major] = candidate
        end
      end
    end
  end
  return jdks
end

return {
  "mfussenegger/nvim-jdtls",
  optional = true,
  opts = function(_, opts)
    table.insert(opts.cmd, "--jvm-arg=-Djava.import.generatesMetadataFilesAtProjectRoot=false")

    local jdks = sdkman_jdks()
    if jdks[25] then
      table.insert(opts.cmd, "--java-executable=" .. vim.fs.joinpath(jdks[25].home, "bin", "java"))
    end

    if next(jdks) then
      local java = opts.settings.java
      java.configuration = java.configuration or {}
      java.configuration.runtimes = java.configuration.runtimes or {}
      for major, jdk in vim.spairs(jdks) do
        table.insert(java.configuration.runtimes, {
          name = runtime_names[major],
          path = jdk.home,
          default = jdk.active or nil,
        })
      end
    end
  end,
}
