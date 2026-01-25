---@type Zavigate.Commands.Subcommand
local M = {
  name = "ResizePane",
  desc = "Resizes the active pane in the specified direction, or opens the interactive resizer",

  impl = function(data)
    local args = (data.namespace and data.namespace.direction) or {}
    local direction = require("zavigate.util").normalize_arg(args[1])
    require("zavigate").resize_pane(direction)
  end,

  ---@type Zavigate.Commands.Subcommand.GroupedArguments[]
  choices = {
    {
      group = "direction",
      help = "Specified direction to resize the pane towards",

      parameter = {
        "Up",
        "Down",
        "Left",
        "Right",
      },
      nargs = 1,
      required = false,
    },
  },
}

return M
