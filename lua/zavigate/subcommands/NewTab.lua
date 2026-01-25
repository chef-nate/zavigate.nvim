---@type Zavigate.Commands.Subcommand
local M = {
  name = "NewTab",
  desc = "Opens a new zellij tab",

  impl = function(_)
    require("zavigate").new_tab()
  end,
}

return M
