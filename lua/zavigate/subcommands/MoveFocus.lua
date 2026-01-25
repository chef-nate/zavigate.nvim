---@type Zavigate.Commands.Subcommand
local M = {
  name = "MoveFocus",
  desc = "Change the actively focussed pane/tab",

  impl = function(data)
    local args = (data.namespace and data.namespace.direction) or {}
    local direction = require("zavigate.util").normalize_arg(args) ---@type Zavigate.Util.Direction
    require("zavigate").move_focus(direction)
  end,

  ---@type Zavigate.Commands.Subcommand.GroupedArguments[]
  choices = {
    {
      group = "direction",
      help = "Specified direction to move focus towards",

      parameter = {
        "Up",
        "Down",
        "Left",
        "Right",
      },
      nargs = 1,
      required = true,
    },
  },
}

return M
