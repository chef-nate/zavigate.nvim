---@type Zavigate.Commands.Subcommand
local M = {
  name = "ToggleFloatingPanes",
  desc = "Toggles floating pane visibility",

  impl = function(_)
    require("zavigate").toggle_floating_panes()
  end,
}

return M
