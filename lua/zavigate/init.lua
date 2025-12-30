---@class Zavigate.Plugin
local M = {}

---@param opts Zavigate.Config.Options.User: plugin options
function M.setup(opts)
  local config = require("zavigate.config")
  local commands = require("zavigate.commands")
  local keymaps = require("zavigate.keymaps")

  -- setup user config
  config.setup(opts)

  -- setup command line commands
  commands.setup()

  -- setup keyamps based on config options
  keymaps.setup(config.options)
end

-- Pane Commands

---@param opts string[]
function M.new_pane(opts)
  require("zavigate.core").new_pane(opts)
end

function M.close_pane()
  require("zavigate.core").close_pane()
end

---@param direction Zavigate.Util.Direction
function M.move_pane(direction)
  require("zavigate.core").move_pane(direction)
end

function M.toggle_floating_panes()
  require("zavigate.core").toggle_floating_panes()
end

function M.toggle_pane_fullscreen()
  require("zavigate.core").toggle_pane_fullscreen()
end

function M.rename_pane(name)
  require("zavigate.core").rename_pane(name)
end

-- Tab Commands
function M.new_tab()
  require("zavigate.core").new_tab()
end

---@param name string
function M.rename_tab(name)
  require("zavigate.core").rename_tab(name)
end

-- Misc Commands

---@param direction Zavigate.Util.Direction
function M.move_focus(direction)
  require("zavigate.core").move_focus(direction)
end

function M.lock()
  require("zavigate.core").lock()
end

function M.unlock()
  require("zavigate.core").unlock()
end

return M
