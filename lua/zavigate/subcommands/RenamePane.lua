---@type Zavigate.Commands.Subcommand
local M = {
  name = "RenamePane",
  desc = "Renames the active pane",

  impl = function(data)
    local name = (data.namespace and data.namespace.name) or ""
    require("zavigate").rename_pane(name)
  end,

  ---@type Zavigate.Commands.Subcommand.GroupedArguments[]
  choices = {
    {
      group = "name",
      help = "New name for active pane",
      nargs = 1,
      required = false,
    },
  },
}

return M
