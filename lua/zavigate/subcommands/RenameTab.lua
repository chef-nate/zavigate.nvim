---@type Zavigate.Commands.Subcommand
local M = {
  name = "RenameTab",
  desc = "Renames the active tab",

  impl = function(data)
    local name = (data.namespace and data.namespace.name) or ""
    require("zavigate").rename_tab(name)
  end,

  ---@type Zavigate.Commands.Subcommand.GroupedArguments[]
  choices = {
    {
      group = "name",
      help = "New name for active tab",
      nargs = 1,
      required = false,
    },
  },
}

return M
