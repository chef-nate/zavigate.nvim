---@type Zavigate.Commands.Subcommand
local M = {
  name = "TogglePaneFullscreen",
  desc = "Toggles the active pane between being fullscreen and paned",

  impl = function(_)
    require("zavigate").toggle_pane_fullscreen()
  end,
}

return M
