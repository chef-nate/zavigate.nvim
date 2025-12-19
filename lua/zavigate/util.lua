local M = {}

M.valid_directions_lrud = {
  left = true,
  right = true,
  up = true,
  down = true,
}

M.valid_directions_lr = {
  left = true,
  right = true,
}

M.hjkl_map = {
  left = "h",
  right = "l",
  up = "k",
  down = "j",
}

-- normalize command vs lua call arguments (single/no arg)
---@param opts table|string|nil
---@return string|nil
function M.normalize_arg(opts)
  if type(opts) == "table" then
    if type(opts.args) == "string" and opts.args ~= "" then
      return opts.args
    else
      return nil
    end
  end

  if type(opts) == "string" or opts == nil then
    return opts
  end

  -- fallback for invalid types
  return nil
end

---@param opts table|string|nil
---@return string[]
function M.normalize_fargs(opts)
  -- (1) command call
  if type(opts) == "table" and type(opts.fargs) == "table" then
    local t = {}
    for _, v in ipairs(opts.fargs) do
      t[#t + 1] = tostring(v)
    end
    return t
  end

  -- (2) lua call - multiple args as table
  if type(opts) == "table" then
    local t = {}
    for _, v in ipairs(opts) do
      t[#t + 1] = tostring(v)
    end
    return t
  end

  -- (3) lua call - single arg
  if opts ~= nil then
    return { tostring(opts) }
  end

  -- (4) no args
  return {}
end

---@param direction Direction
function M.validate_direction_lrud(direction)
  if not M.valid_directions_lrud[direction] then
    error(string.format("Invalid direction: %s", tostring(direction)))
  end
end

function M.zellij_action(opts)
  local cmd = vim.list_extend({ "zellij", "action" }, opts)
  vim.system(cmd)
end

---@param msg string
---@param title string -- typically name of ucmd/function calling this
---@param lvl? number -- defaults to INFO
---@param opts? table -- any additional opts
function M.notify(msg, title, lvl, opts)
  local notify_opts = vim.tbl_deep_extend("force", {}, { title = title }, opts or {})
  vim.notify(msg, lvl or vim.log.levels.INFO, notify_opts)
end

---@param msg string
---@param title string -- typically name of ucmd/function calling this
---@param opts? table -- any additional vim.notify options
function M.info(msg, title, opts)
  M.notify(msg, title, vim.log.levels.INFO, opts)
end

---@param msg string
---@param title string
---@param opts? table
function M.warn(msg, title, opts)
  M.notify(msg, title, vim.log.levels.WARN, opts)
end

---@param msg string
---@param title string
---@param opts? table
function M.error(msg, title, opts)
  M.notify(msg, title, vim.log.levels.ERROR, opts)
end

return M
