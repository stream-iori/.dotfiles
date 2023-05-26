return {
  cmd = {
    "jdtls",
  },
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  root_dir = require("jdtls.setup").find_root { "pom.xml", ".git", "mvnw", "gradlew" },
}
