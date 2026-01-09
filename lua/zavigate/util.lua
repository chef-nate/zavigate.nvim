---@mod zavigate.util

---@class Zavigate.Util
---Shared utilities used across the plugin
local M = {}

---@type table<string, boolean>
M.valid_selection_new_pane = {
  right = true,
  down = true,
  any = true,
  floating = true,
}

---@type table<string, boolean>
M.valid_directions_lrud = {
  left = true,
  right = true,
  up = true,
  down = true,
  Left = true,
  Right = true,
  Up = true,
  Down = true,
}

---@type table<string, boolean>
M.valid_directions_lr = {
  left = true,
  right = true,
}

---@type table<string, boolean>
M.valid_directions_dr = {
  right = true,
  down = true,
}

---@type table<string, string>
M.hjkl_map = {
  left = "h",
  right = "l",
  up = "k",
  down = "j",
}

---@param tbl table<string, boolean>
---@param input string
---@param throw_on_false boolean?
---@return boolean
M.validate_against_table = function(tbl, input, throw_on_false)
  -- default value for throw_on_false is true
  throw_on_false = throw_on_false == nil and true or throw_on_false

  -- check if input is valid against table
  if not tbl[input] then
    if throw_on_false then
      M.error(
        string.format("Zavigate: invalid argument '%s' was supplied", tostring(input)),
        "Zavigate"
      )
    end
    return false
  end

  -- if not early returned then must be valid
  return true
end

---@param arg table|string|nil arg to be normalized
---@return string|nil normalized the argument as a string ( or nil if no argument supplied )
function M.normalize_arg(arg)
  if type(arg) == "table" then
    if type(arg.args) == "string" and arg.args ~= "" then
      return arg.args
    else
      return nil
    end
  end

  if type(arg) == "string" or arg == nil then
    return arg
  end

  -- fallback for invalid types
  return nil
end

---@param fargs table|string|nil fargs to be normalized
---@return string[] normalized string array of all fargs supplied
function M.normalize_fargs(fargs)
  -- (1) command call
  if type(fargs) == "table" and type(fargs.fargs) == "table" then
    local t = {}
    for _, v in ipairs(fargs.fargs) do
      t[#t + 1] = tostring(v)
    end
    return t
  end

  -- (2) lua call - multiple args as table
  if type(fargs) == "table" then
    local t = {}
    for _, v in ipairs(fargs) do
      t[#t + 1] = tostring(v)
    end
    return t
  end

  -- (3) lua call - single arg
  if fargs ~= nil then
    return { tostring(fargs) }
  end

  -- (4) no args
  return {}
end

---@param opts string[] array of commands for 'zellij action ...' to execute
---@return nil
function M.zellij_action(opts)
  local cmd = vim.list_extend({ "zellij", "action" }, opts)
  vim.system(cmd)
end

---@param msg string -- message to notify
---@param title string -- typically name of ucmd/function calling this
---@param lvl? number -- defaults to INFO
---@param opts? table<string, any> -- any additional opts
function M.notify(msg, title, lvl, opts)
  local notify_opts = vim.tbl_deep_extend("force", {}, { title = title }, opts or {})
  vim.notify(msg, lvl or vim.log.levels.INFO, notify_opts)
end

---@param msg string -- message to notify as info
---@param title string -- typically name of ucmd/function calling this
---@param opts? table<string, any> -- any additional vim.notify options
function M.info(msg, title, opts)
  M.notify(msg, title, vim.log.levels.INFO, opts)
end

---@param msg string -- message to notify as a warning
---@param title string -- typically name of ucmd/function calling this
---@param opts? table<string, any> -- any additional vim.notify options
function M.warn(msg, title, opts)
  M.notify(msg, title, vim.log.levels.WARN, opts)
end

---@param msg string -- message to notify as an error
---@param title string -- typically name of ucmd/function calling this
---@param opts? table<string, any> -- any additional vim.notify options
function M.error(msg, title, opts)
  M.notify(msg, title, vim.log.levels.ERROR, opts)
end

---@param choices string[] -- list of all possible autocomplete choices
---@param lead string -- characters to autocomplete from
---@return string[] -- array containing all valid autocomplete choices
function M.complete_from_list(choices, lead)
  return vim
    .iter(choices)
    :filter(function(choice)
      return choice:find(lead) ~= nil
    end)
    :totable()
end

return M
