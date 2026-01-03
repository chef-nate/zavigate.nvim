---@tag zavigate-config
---@mod zavigate.config Configuration management for zavigate.nvim.
---@brief [[
--- Merges user configuration with defaults.
---
--- This module is configured automatically by `require("zavigate").setup()`.
---@brief ]]

---@class Config
--- Configuration management.
---@field options Config.Options Merged user and default options.
---@field setup fun(opts?: Config.Options.User): nil Merge user options into defaults.
local M = {}

---@tag zavigate-config-options
---@class Config.Options
--- User-facing configuration options.
---@field disable_keymaps boolean Disable default keymaps. Default: false.

---@class Config.Options.User
--- User-supplied options (all optional).
---@field disable_keymaps? boolean Disable default keymaps. Default: false.

---@class Config.Options.Defaults: Config.Options

---@type Config.Options.Defaults
local defaults = {
  disable_keymaps = false,
}

---@type Config.Options
M.options = vim.tbl_deep_extend("force", {}, defaults)

---@tag zavigate-config-setup
--- Merge user options into defaults and store them in `M.options`.
---@param opts? Config.Options.User Plugin options.
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})
end

return M
