---@type Zavigate.Commands.Subcommand
local M = {
  name = "NewPane",
  desc = "Opens a new zellij pane in the specified direction, or with the specified arguments.",

  impl = function(data)
    local args = (data.namespace and data.namespace.direction) or {}
    local args_normalized = require("zavigate.util").normalize_fargs(args)
    require("zavigate").new_pane(args_normalized)
  end,

  ---@type Zavigate.Commands.Subcommand.GroupedArguments[]
  choices = {
    -- standard directions to open
    {
      group = "direction",
      help = "Specified direction to open new pane into",

      args = {
        "Right",
        "Down",
        "Floating",
        "Any",
      },
      nargs = "*",

      required = false,
    },
  },
}

---@type mega.cmdparse.ParameterInputOptions

return M
