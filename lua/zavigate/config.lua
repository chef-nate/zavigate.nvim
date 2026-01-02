---@mod zavigate.config

---@class Zavigate.Config
--- Configuration management
---@field options Zavigate.Config.Options Merged user and default options
---@field setup fun(opts?: Zavigate.Config.Options.User): nil Setup config and user options
local M = {}

---@class Zavigate.Config.Options
--- User facing configuration options
---@field disable_keymaps boolean Whether the default zavigate keymaps should be disabled

---@class Zavigate.Config.Options.Defaults: Zavigate.Config.Options
---@class Zavigate.Config.Options.User: Zavigate.Config.Options

---@type Zavigate.Config.Options.Defaults
local defaults = { disable_keymaps = false }

---@param opts Zavigate.Config.Options.User: plugin options
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {}) ---@type Zavigate.Config.Options
end

return M
