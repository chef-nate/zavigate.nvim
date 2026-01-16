---@mod zavigate.config Configuration management for zavigate.nvim.
---@brief [[
--- Merges user configuration with defaults.
---
--- This module is configured automatically by `require("zavigate").setup()`.
---@brief ]]

---@class Zavigate.Config
--- Configuration management.
---@field options Zavigate.Config.Options Merged user and default options.
---@field setup fun(opts?: Zavigate.Config.Options.User): nil Merge user options into defaults.
local M = {}

---@alias Zavigate.Config.Options.KeymapPresets
---| '"default"' # Default: alt-hjkl and related alt key shortcut keymaps
---| '"extended"' # Extended: default keymaps as well as ctrl-p pane keymaps

---@class Zavigate.Config.Options
--- User-facing configuration options.
---@field disable_keymaps boolean Disable default keymaps. Default: false.
---@field keymap_preset Zavigate.Config.Options.KeymapPresets Which inbuilt keymap preset to use. Default: "default".

---@class Zavigate.Config.Options.User
--- User-supplied options (all optional).
---@field disable_keymaps? boolean Disable default keymaps. Default: false.
---@field keymap_preset? Zavigate.Config.Options.KeymapPresets Specify keymap preset. Default: "default".

---@class Zavigate.Config.Options.Defaults: Zavigate.Config.Options

---@type Zavigate.Config.Options.Defaults
local defaults = {
  disable_keymaps = false,
  keymap_preset = "default",
}

---@type Zavigate.Config.Options
M.options = vim.tbl_deep_extend("force", {}, defaults)

---@tag zavigate-config-setup
--- Merge user options into defaults and store them in `M.options`.
---@param opts? Zavigate.Config.Options.User Plugin options.
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})
end

return M
