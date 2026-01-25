---@mod zavigate.commands

---@class Zavigate.Commands
---User command setup for zavigate.nvim
---@field setup fun(): nil
local M = {}

---@class Zavigate.Commands.Subcommand
---@field name string Command Name
---@field desc string Command description
---@field impl fun(data: table) Implementation
---@field choices? Zavigate.Commands.Subcommand.GroupedArguments[] | fun(data: table): string[] Completion for command arguments

---@alias Zavigate.Commands.Subcommand.Argument string Option name (e.g. 'Down' or '--floating')

---@class Zavigate.Commands.Subcommand.GroupedArguments
---@field group string grouped name to identify arguments
---@field parameter? Zavigate.Commands.Subcommand.Argument[] array of different grouped arguments
---@field nargs mega.cmdparse.MultiNumber number of arguments taken
---@field help string help description for the subcommand options
---@field required boolean whether at least one argument is required for the ucmd

local function setup_legacy()
  require("zavigate.util").warn(
    "mega.cmdparse not installed. zavigate usercommands are disabled.",
    "zavigate.nvim"
  )
end

---@return Zavigate.Commands.Subcommand[]
local function gather_subcommands()
  local res = {} ---@type Zavigate.Commands.Subcommand[]
  -- gather all subcommand file paths
  local files = vim.api.nvim_get_runtime_file("lua/zavigate/subcommands/*.lua", true)

  for _, file in ipairs(files) do
    -- get the file basename
    local filename = vim.fs.basename(file)

    -- stip .lua from name
    filename = filename:gsub("%.lua", "")
    table.insert(res, require(string.format("zavigate.subcommands.%s", filename)))
  end

  return res
end

local function setup_cmdparse()
  local cmdparse = require("mega.cmdparse")

  -- create :Zavigate
  local zav_parser = cmdparse.ParameterParser.new({
    name = "Zavigate",
    help = "Zavigate commands",
  })

  -- glob all subcommands in 'subcommands/' directory
  local subcommands = gather_subcommands() ---@type Zavigate.Commands.Subcommand[]

  -- add subcommands and completion to subparser
  local zav_subparser = zav_parser:add_subparsers({
    destination = "subcommand",
    help = "zavigate subcommands",
  })

  for _, subcmd in ipairs(subcommands) do
    if subcmd == nil or subcmd.name == nil or subcmd.impl == nil or subcmd.desc == nil then
      goto continue
    end

    local sub = zav_subparser:add_parser({
      name = subcmd.name,
      help = subcmd.desc,
    })

    -- check if this subcommand offers completion and setup if so
    if subcmd.choices ~= nil then
      -- function is also valid for choices...
      if type(subcmd.choices) ~= "function" then
        -- array of subcommand arguments so

        ---@param groupedarg Zavigate.Commands.Subcommand.GroupedArguments
        for _, groupedarg in ipairs(subcmd.choices) do
          sub:add_parameter({
            name = groupedarg.group,
            nargs = groupedarg.nargs,
            help = groupedarg.help,
            choices = groupedarg.parameter,
            required = groupedarg.required,
          })
        end
      end
    end

    sub:set_execute(subcmd.impl)
    ::continue::
  end

  cmdparse.create_user_command(zav_parser)
end

function M.setup()
  local mega_installed, _ = pcall(require, "mega.cmdparse")
  if not mega_installed then
    setup_legacy()
    return
  end

  setup_cmdparse()
end

return M
