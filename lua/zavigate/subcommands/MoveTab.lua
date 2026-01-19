---@type Zavigate.Commands.Subcommand
local M = {
  name = "MoveTab",
  desc = "Move the position of the active tab",

  impl = function(data)
    local args = (data.namespace and data.namespace.direction) or {}
    local direction = require("zavigate.util").normalize_arg(args[1])

    require("zavigate").move_tab(direction)
  end,

  ---@type Zavigate.Commands.Subcommand.GroupedArguments[]
  choices = {
    {
      group = "direction",
      help = "Specified direction to move the active tab towards",

      args = {
        "Left",
        "Right",
      },
      nargs = "*",
      required = true,
    },
  },
}

return M
