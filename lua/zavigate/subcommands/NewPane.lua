---@type Zavigate.Commands.Subcommand
local M = {
  name = "NewPane",
  desc = "Opens a new zellij pane in the specified direction, or with the specified arguments.",

  impl = function(data)
    local args = (data.namespace and data.namespace.direction) or {}
    local args_normalized = require("zavigate.util").normalize_arg(args)
    require("zavigate").new_pane({ args_normalized })
  end,

  ---@type Zavigate.Commands.Subcommand.GroupedArguments[]
  choices = {
    -- standard directions to open
    {
      group = "direction",
      help = "Specified direction to open new pane into",

      parameter = {
        "Right",
        "Down",
        "Floating",
        "Any",
      },
      nargs = 1,

      required = false,
    },

    -- {
    --   group = "zellij_cmd",
    --   help = "test zellij cmd",
    --
    --   parameter = function(data)
    --     return { "" }
    --   end,
    --
    --   nargs = 1,
    --   required = false,
    -- },
  },
}

return M
