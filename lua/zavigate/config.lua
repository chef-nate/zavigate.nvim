---@class Zavigate.Config
local M = {}

---@class Zavigate.Config.DefaultOptions
M.defaults = { disable_keymaps = false }

---@class Zavigate.Config.Options
M.options = {}

---@param opts Zavigate.Config.UserOptions: plugin options
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

return M
