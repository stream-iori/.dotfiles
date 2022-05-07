local go = require "go"
local M = {}
 
M.setup = function()
   go.setup {
      -- set to go1.18beta1 if necessary
      go = "go",

      -- if set to 'gopls' will use gopls format, also goimport
      goimport = "gopls",
      fillstruct = "gopls",

      -- if set to gopls will use gopls format
      gofmt = "gopls",

      -- false if you want to use other formatter tool(e.g. efm, nulls)
      lsp_document_formatting = false,
   }
end
return M
