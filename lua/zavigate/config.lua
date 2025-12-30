---@class Zavigate.Config
local M = {}

---@class Zavigate.Config.Options.Defaults
local defaults = { disable_keymaps = false }

---@class Zavigate.Config.Options
M.options = {}

---@param opts Zavigate.Config.Options.User: plugin options
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})
end

return M
