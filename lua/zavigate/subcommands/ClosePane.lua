---@type Zavigate.Commands.Subcommand
local M = {
  name = "ClosePane",
  desc = "Closes the active pane",
  nargs = nil,

  impl = function(_)
    require("zavigate").close_pane()
  end,
}

return M
