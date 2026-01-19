---@type Zavigate.Commands.Subcommand
local M = {
  name = "Lock",
  desc = "Lock Zellij keybinds",

  impl = function(_)
    require("zavigate").lock()
  end,
}

return M
