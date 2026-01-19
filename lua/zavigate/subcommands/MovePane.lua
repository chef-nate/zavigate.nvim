---@type Zavigate.Commands.Subcommand
local M = {
  name = "MovePane",
  desc = "Move the position of the active pane",

  impl = function(data)
    local args = (data.namespace and data.namespace.direction) or {}
    local direction = require("zavigate.util").normalize_arg(args[1])

    require("zavigate").move_pane(direction)
  end,

  ---@type Zavigate.Commands.Subcommand.GroupedArguments[]
  choices = {
    {
      group = "direction",
      help = "Specified direction to move the active pane towards",

      args = {
        "Up",
        "Down",
        "Left",
        "Right",
      },

      nargs = "*",
      required = true,
    },
  },
}

return M
