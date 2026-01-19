---@type Zavigate.Commands.Subcommand
local M = {
  name = "Unlock",
  desc = "Unlock zellij keybinds",

  impl = function(_)
    require("zavigate").unlock()
  end,
}

return M
