local M = {}
local ts = vim.treesitter

local function node_type(node)
  return node and node:type()
end

local function field(node, key)
  return node and node:field(key)[1]
end

local function text(node, bufnr)
  if node and not node:missing() and not node:has_error() then
    return ts.get_node_text(node, bufnr)
  end
end

local function name(node, bufnr)
  return text(field(node, "name"), bufnr)
end

local function file_path(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename ~= "" and vim.bo[bufnr].buftype == "" then
    local root = vim.fs.root(vim.fs.dirname(filename), ".git") or LazyVim.root({ buf = bufnr })
    return vim.fs.relpath(root, filename) or filename
  end
end

local java_types = {
  annotation_type_declaration = true,
  class_declaration = true,
  enum_declaration = true,
  interface_declaration = true,
  record_declaration = true,
}

local java_methods = {
  compact_constructor_declaration = true,
  constructor_declaration = true,
  method_declaration = true,
}

local java_bodies = {
  annotation_type_body = true,
  class_body = true,
  enum_body = true,
  interface_body = true,
}

local function java_owner(node)
  local body = node:parent()
  if node_type(body) == "enum_body_declarations" then
    body = body:parent()
  end
  return java_bodies[node_type(body)] and body:parent()
end

local function java_package_name(node, bufnr)
  if node_type(node) == "scoped_identifier" then
    local scope = java_package_name(field(node, "scope"), bufnr)
    local segment = name(node, bufnr)
    return scope and segment and scope .. "." .. segment or nil
  end
  return text(node, bufnr)
end

local function java_class_name(node, bufnr)
  local parts = {}
  while java_types[node_type(node)] do
    local segment = name(node, bufnr)
    if not segment then
      return
    end
    parts[#parts + 1] = segment

    local parent = node:parent()
    if node_type(parent) == "program" then
      for child in parent:iter_children() do
        if child:type() == "package_declaration" then
          for package_child in child:iter_children() do
            local kind = package_child:type()
            if kind == "identifier" or kind == "scoped_identifier" then
              local package_name = java_package_name(package_child, bufnr)
              if not package_name then
                return
              end
              parts[#parts + 1] = package_name
              break
            end
          end
          break
        end
      end
      return table.concat(vim.fn.reverse(parts), ".")
    end
    node = java_owner(node)
  end
end

local function java_signature(node, owner, bufnr)
  local parameters = field(node, "parameters")
  if node:type() == "compact_constructor_declaration" then
    parameters = field(owner, "parameters")
  end
  if not parameters then
    return
  end

  local types = {}
  for parameter in parameters:iter_children() do
    local kind = parameter:type()
    if kind == "formal_parameter" or kind == "spread_parameter" then
      local type_node = field(parameter, "type")
      if kind == "spread_parameter" then
        for child in parameter:iter_children() do
          if child:named() and not child:extra() and child:type() ~= "modifiers" then
            type_node = child
            break
          end
        end
      end
      local type_name = text(type_node, bufnr)
      if not type_name then
        return
      end
      local dimensions = text(field(parameter, "dimensions"), bufnr) or ""
      local suffix = kind == "spread_parameter" and "..." or dimensions
      types[#types + 1] = (type_name .. suffix):gsub("%s+", " ")
    end
  end
  return "(" .. table.concat(types, ", ") .. ")"
end

local function java_member_name(node, member, bufnr)
  local owner = java_owner(node)
  local class = java_class_name(owner, bufnr)
  if not class or not member then
    return
  end
  local kind = node:type()
  if java_methods[kind] then
    for sibling in node:parent():iter_children() do
      local sibling_kind = sibling:type()
      if
        java_methods[sibling_kind]
        and (kind == "method_declaration") == (sibling_kind == "method_declaration")
        and not sibling:equal(node)
        and name(sibling, bufnr) == member
      then
        local signature = java_signature(node, owner, bufnr)
        return signature and class .. "#" .. member .. signature or nil
      end
    end
  end
  return class .. "#" .. member
end

local function java_reference(node, bufnr)
  local child
  while node do
    local kind = node:type()
    if java_types[kind] then
      return java_class_name(node, bufnr)
    elseif java_methods[kind] or kind == "enum_constant" or kind == "annotation_type_element_declaration" then
      return java_member_name(node, name(node, bufnr), bufnr)
    elseif kind == "field_declaration" or kind == "constant_declaration" then
      if node_type(child) ~= "variable_declarator" then
        local declarators = node:field("declarator")
        if #declarators > 1 then
          return nil, "Move the cursor onto a specific field"
        end
        child = declarators[1]
      end
      return java_member_name(node, name(child, bufnr), bufnr)
    end
    child, node = node, node:parent()
  end
end

local ts_named = {
  abstract_class_declaration = true,
  class_declaration = true,
  function_declaration = true,
  generator_function_declaration = true,
  interface_declaration = true,
  internal_module = true,
}

local ts_members = {
  abstract_method_signature = true,
  method_definition = true,
  method_signature = true,
  property_signature = true,
  public_field_definition = true,
}

local function typescript_name(node, bufnr, has_symbol)
  local kind = node_type(node)
  if ts_named[kind] then
    return name(node, bufnr)
  elseif ts_members[kind] then
    local body = node_type(node:parent())
    local member = field(node, "name")
    if (body == "class_body" or body == "interface_body") and node_type(member) ~= "computed_property_name" then
      return text(member, bufnr)
    end
  elseif kind == "variable_declarator" and node_type(field(node, "value")) == "arrow_function" then
    local binding = field(node, "name")
    if node_type(binding) == "identifier" then
      return text(binding, bufnr)
    end
  elseif not has_symbol and kind == "export_statement" then
    return typescript_name(field(node, "declaration"), bufnr, false)
  elseif not has_symbol and (kind == "lexical_declaration" or kind == "variable_declaration") then
    local binding
    for child in node:iter_children() do
      if child:type() == "variable_declarator" then
        if binding then
          return
        end
        binding = child
      end
    end
    return typescript_name(binding, bufnr, false)
  end
end

local function python_class_method(node)
  local parent = node:parent()
  if node_type(parent) == "decorated_definition" then
    parent = parent:parent()
  end
  return node_type(parent) == "block" and node_type(parent:parent()) == "class_definition"
end

local function python_name(node, bufnr, has_symbol)
  local kind = node_type(node)
  if kind == "class_definition" or kind == "function_definition" then
    return name(node, bufnr)
  elseif not has_symbol and kind == "decorated_definition" then
    return name(field(node, "definition"), bufnr)
  elseif kind == "assignment" and node_type(node:parent()) == "expression_statement" then
    local block = node:parent():parent()
    if node_type(block) ~= "block" then
      return
    end
    local owner = block:parent()
    local lhs = field(node, "left")
    if node_type(owner) == "class_definition" and node_type(lhs) == "identifier" then
      return text(lhs, bufnr)
    elseif
      node_type(owner) == "function_definition"
      and name(owner, bufnr) == "__init__"
      and python_class_method(owner)
      and node_type(lhs) == "attribute"
    then
      local parameters = field(owner, "parameters")
      local receiver = parameters and parameters:named_child(0)
      if node_type(receiver) == "typed_parameter" then
        receiver = receiver:named_child(0)
      end
      local object = field(lhs, "object")
      if node_type(object) == "identifier" and text(object, bufnr) == "self" and text(receiver, bufnr) == "self" then
        return text(field(lhs, "attribute"), bufnr), owner
      end
    end
  end
end

local rust_named = {
  enum_item = true,
  enum_variant = true,
  field_declaration = true,
  function_item = true,
  function_signature_item = true,
  mod_item = true,
  struct_item = true,
  trait_item = true,
}

local function rust_name(node, bufnr, has_symbol)
  local kind = node:type()
  if rust_named[kind] then
    return name(node, bufnr)
  elseif has_symbol and kind == "impl_item" then
    local type_name = text(field(node, "type"), bufnr)
    local trait = field(node, "trait")
    if trait then
      local trait_name = text(trait, bufnr)
      return type_name and trait_name and "<" .. type_name .. " as " .. trait_name .. ">" or nil
    end
    return type_name
  end
end

local languages = {
  python = { name = python_name, separator = "." },
  rust = { name = rust_name, separator = "::" },
  tsx = { name = typescript_name, separator = "." },
  typescript = { name = typescript_name, separator = "." },
}

local function scoped_reference(node, bufnr, language)
  local parts = {}
  while node do
    local segment, skip = language.name(node, bufnr, #parts > 0)
    if segment then
      parts[#parts + 1] = segment
    end
    node = (skip or node):parent()
  end
  if #parts > 0 then
    return table.concat(vim.fn.reverse(parts), language.separator)
  end
end

function M.reference(bufnr, position)
  if vim.api.nvim_buf_get_name(bufnr) == "" or vim.bo[bufnr].buftype ~= "" then
    return nil, "Current buffer has no file path"
  end
  local lang = ts.language.get_lang(vim.bo[bufnr].filetype)
  local language = languages[lang]
  if lang ~= "java" and not language then
    return nil, "Copy Reference does not support this filetype"
  end

  local parser = ts.get_parser(bufnr, lang)
  if not parser then
    return nil, "No Tree-sitter parser for " .. lang
  end
  parser:parse()
  local node = ts.get_node({ bufnr = bufnr, lang = lang, pos = position })
  if node then
    if lang == "java" then
      local reference, reason = java_reference(node, bufnr)
      if reference or reason then
        return reference, reason
      end
    else
      local symbol = scoped_reference(node, bufnr, language)
      if symbol then
        return file_path(bufnr) .. "#" .. symbol
      end
    end
  end
  return nil, "No named declaration at the cursor"
end

local function copy(value, description)
  vim.fn.setreg("+", value, "v")
  vim.notify("Copied " .. description .. ": " .. value)
end

function M.copy_symbol()
  local bufnr = vim.api.nvim_get_current_buf()
  local position = vim.api.nvim_win_get_cursor(0)
  local reference, reason = M.reference(bufnr, { position[1] - 1, position[2] })
  if reference then
    copy(reference, "reference")
  else
    if vim.api.nvim_buf_get_name(bufnr) ~= "" and vim.bo[bufnr].buftype == "" then
      reason = reason .. "; use <leader>fY to copy the file path"
    end
    vim.notify(reason, vim.log.levels.WARN)
  end
end

function M.copy_path()
  local path = file_path(vim.api.nvim_get_current_buf())
  if path then
    copy(path, "relative path")
  else
    vim.notify("Current buffer has no file path", vim.log.levels.WARN)
  end
end

return M
