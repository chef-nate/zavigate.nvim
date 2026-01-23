---@mod zavigate

---@brief [
--- zavigate.nvim integrates Zellij movement and pane/tab navigation into Neovim.
---
--- Requirements
--- - Neovim 0.9+
--- - Zellij
---
--- Installation (lazy.nvim)
--- Add this to your plugin spec:
---
--- ```lua
---{
---"chef-nate/zavigate.nvim",
---opts = {},
---}
---]
---@class Zavigate.Plugin
--- Plugin entry point
---@field setup fun(opts?: Zavigate.Config.Options.User): nil Setup the plugin with the user options.
local M = {}

--- Setup zavigate.
---@param opts? Zavigate.Config.Options.User: plugin options
---@return nil
function M.setup(opts)
  local config = require("zavigate.config")
  local commands = require("zavigate.commands")
  local keymaps = require("zavigate.keymaps")

  config.setup(opts or {})

  commands.setup()

  keymaps.setup(config.options)
end

-- Pane Commands

---@param opts string[]
---@return nil
function M.new_pane(opts)
  require("zavigate.core").new_pane(opts)
end

---@return nil
function M.close_pane()
  require("zavigate.core").close_pane()
end

---@param direction Zavigate.Util.Direction
---@return nil
function M.move_pane(direction)
  require("zavigate.core").move_pane(direction)
end

---@return nil
function M.toggle_floating_panes()
  require("zavigate.core").toggle_floating_panes()
end

---@return nil
function M.toggle_pane_fullscreen()
  require("zavigate.core").toggle_pane_fullscreen()
end

---@return nil
function M.rename_pane(name)
  require("zavigate.core").rename_pane(name)
end

---@return nil
---@param direction? Zavigate.Util.Direction
function M.resize_pane(direction)
  require("zavigate.core").resize_pane(direction)
end

-- Tab Commands
---@return nil
function M.new_tab()
  require("zavigate.core").new_tab()
end

---@param name string
---@return nil
function M.rename_tab(name)
  require("zavigate.core").rename_tab(name)
end

---@param direction Zavigate.Util.DirectionLR
---@return nil
function M.move_tab(direction)
  require("zavigate.core").move_tab(direction)
end

-- Misc Commands

---@return nil
---@param direction Zavigate.Util.Direction
function M.move_focus(direction)
  require("zavigate.core").move_focus(direction)
end

---@return nil
function M.lock()
  require("zavigate.core").lock()
end

---@return nil
function M.unlock()
  require("zavigate.core").unlock()
end

return M
