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

---@alias Config.Options.KeymapPresets
---| '"default"' # Default: alt-hjkl and related alt key shortcut keymaps
---| '"extended"' # Extended: default keymaps as well as ctrl-p pane keymaps

---@class Config.Options
--- User-facing configuration options.
---@field disable_keymaps boolean Disable default keymaps. Default: false.
---@field keymap_preset Config.Options.KeymapPresets Which inbuilt keymap preset to use. Default: "default".
---@field autolock_zellij boolean Disable zellij keybinds when in neovim so it cant conflict (i.e. lock keybinds). Default: true

---@class Config.Options.User
--- User-supplied options (all optional).
---@field disable_keymaps? boolean Disable default keymaps. Default: false.
---@field keymap_preset? Config.Options.KeymapPresets Specify keymap preset. Default: "default".
---@field autolock_zellij? boolean Lock Zellij keybinds automatically

---@class Config.Options.Defaults: Config.Options

---@type Config.Options.Defaults
local defaults = {
  disable_keymaps = false,
  keymap_preset = "default",
  autolock_zellij = true,
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
