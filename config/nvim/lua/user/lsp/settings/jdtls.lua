return {
  cmd = {
    "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/bin/java", -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
  },
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  root_dir = require("jdtls.setup").find_root { ".git", "pom.xml" },

  settings = {
    --   ["java.format.settings.url"] = home .. "/.config/nvim/language-servers/java-google-formatter.xml",
    --   ["java.format.settings.profile"] = "GoogleStyle",
    java = {
      home = "/Library/Java/JavaVirtualMachines/temurin-19.jdk/Contents/Home/",
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/",
          },
          {
            name = "JavaSE-1.8",
            path = "/Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home/",
          },
        },
      },
    },
  },
}
