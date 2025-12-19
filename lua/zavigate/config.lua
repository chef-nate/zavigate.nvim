---@class Zavigate.Config
local M = {}

---@class Zavigate.DefaultOptions
M.defaults = { disable_keymaps = false }

---@class Zavigate.Options
M.options = {}

---@param opts Zavigate.UserOptions: plugin options
function M.setup(opts)
  M.options = vim.tbl_deep_extend('force', {}, M.defaults, opts or {})
end

return M
