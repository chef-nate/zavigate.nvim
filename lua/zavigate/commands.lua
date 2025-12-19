local M = {}

local dispatch = {
  -- Pane Commands

  ---@param cmd_opts table|string|nil
  NewPane = function(cmd_opts)
    local direction = require("zavigate.util").normalize_arg(cmd_opts) ---@type Direction|nil
    require("zavigate").new_pane(direction)
  end,

  ClosePane = function()
    require("zavigate").close_pane()
  end,

  ---@param cmd_opts table|string|nil
  MovePane = function(cmd_opts)
    local direction = require("zavigate.util").normalize_arg(cmd_opts) ---@type Direction|nil
    if direction == nil then
      require("zavigate.util").error(
        "Invalid direction: type nil is not allowed",
        "Zavigate MovePane"
      )
      return
    end
    require("zavigate").move_pane(direction)
  end,

  ToggleFloatingPanes = function()
    require("zavigate").toggle_floating_panes()
  end,

  TogglePaneFullscreen = function()
    require("zavigate").toggle_pane_fullscreen()
  end,

  -- Tab Commands

  -- Misc Commands

  ---@param cmd_opts table|string|nil
  MoveFocus = function(cmd_opts)
    local direction = require("zavigate.util").normalize_arg(cmd_opts) ---@type Direction|nil
    if direction == nil then
      require("zavigate.util").error(
        "Invalid direction: type nil is not allowed",
        "Zavigate MoveFocus"
      )
      return
    end
    require("zavigate").move_focus(direction)
  end,
}

function M.setup() end

return M
