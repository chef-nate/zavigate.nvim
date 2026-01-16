---@mod zavigate.commands

---@class Zavigate.Commands
---User command definitions for zavigate
---@field setup fun(): nil
---@field zavigate_cmd fun(opts: {fargs:  string[]}): nil
---@field subcommand_tbl table<string, Zavigate.Commands.Subcommand>
local M = {}

---@class Zavigate.Commands.Subcommand
---A single subcommand for the ':Zavigate' prefix
---@field desc string Subcommand description
---@field nargs NArgsValue Vim command nargs value
---@field impl fun(args: string[], opts: table) Implementation
---@field choices? string[] completion choices

---@class Zavigate.Commands.Subcommands.CompletionChoice
---A single completion choice for a subcommand
---@field choice string

---@alias NArgsValue
---| "0" -- none
---| "1" -- exactly 1
---| "*" -- any number (0+)
---| "?" -- 0 or 1
---| "+" -- 1 or more

---@type table<string, Zavigate.Commands.Subcommand>
M.subcommand_tbl = {}

---@enum Zavigate.Commands.Nargs
local NARGS = {
  NONE = "0",
  ONE = "1",
  ZERO_OR_ONE = "?",
  ZERO_OR_MORE = "*",
  ONE_OR_MORE = "+",
}

---@type table<Zavigate.Commands.Nargs, string?>
local NARGS_megacmd = {
  [NARGS.NONE] = nil,
  [NARGS.ONE] = nil,
  [NARGS.ZERO_OR_ONE] = "?",
  [NARGS.ZERO_OR_MORE] = "*",
  [NARGS.ONE_OR_MORE] = "+",
}

-- Pane Subcommands
---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.NewPane = {
  desc = "Opens a new Zellij pane in the specified direction.",
  nargs = NARGS.ZERO_OR_MORE,

  impl = function(args, _)
    local args_normalized = require("zavigate.util").normalize_fargs(args)
    require("zavigate").new_pane(args_normalized)
  end,

  choices = {
    "Down",
    "Right",
    "Floating",
    "Any",
  },
}

---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.ClosePane = {
  desc = "",
  nargs = NARGS.NONE,

  impl = function(_, _)
    require("zavigate").close_pane()
  end,
}

---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.MovePane = {
  desc = "",
  nargs = NARGS.ONE,

  impl = function(args, _)
    local direction = require("zavigate.util").normalize_arg(args[1]) ---@type Zavigate.Util.Direction|nil

    if direction == nil then
      require("zavigate.util").error(
        string.format("Invalid direction: '%s' is not a valid argument", tostring(args[1])),
        "Zavigate MoveFocus"
      )
      return
    end

    require("zavigate").move_pane(direction)
  end,

  choices = {
    "Up",
    "Down",
    "Left",
    "Right",
  },
}

---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.ToggleFloatingPanes = {
  desc = "",
  nargs = NARGS.NONE,

  impl = function(_, _)
    require("zavigate").toggle_floating_panes()
  end,
}

---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.TogglePaneFullscreen = {
  desc = "",
  nargs = NARGS.NONE,

  impl = function(_, _)
    require("zavigate").toggle_pane_fullscreen()
  end,
}

---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.RenamePane = {
  desc = "",
  nargs = NARGS.ZERO_OR_ONE,

  impl = function(args, _)
    local args_normalized = require("zavigate.util").normalize_arg(args[1])
    if args_normalized == nil then
      args_normalized = ""
    end

    require("zavigate").rename_pane(args_normalized)
  end,
}

---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.ResizePane = {
  desc = "Resizes the active pane in the specified direction. If none provided, interactive resize mode is started",
  nargs = NARGS.ZERO_OR_ONE,

  impl = function(args, _)
    local args_normalized = require("zavigate.util").normalize_arg(args[1])

    require("zavigate").resize_pane(args_normalized)
  end,

  choices = {
    "Up",
    "Down",
    "Left",
    "Right",
  },
}

-- Tab Subcommands
---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.NewTab = {
  desc = "Opens a new Zellij tab",
  nargs = NARGS.NONE,
  impl = function(_, _)
    require("zavigate").new_tab()
  end,
}

---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.RenameTab = {
  desc = "Renames the active tab",
  nargs = NARGS.ZERO_OR_ONE,

  impl = function(args, _)
    local args_normalized = require("zavigate.util").normalize_arg(args[1])
    if args_normalized == nil then
      args_normalized = ""
    end

    require("zavigate").rename_tab(args_normalized)
  end,
}

---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.MoveTab = {
  desc = "Moves the active tab",
  nargs = NARGS.ONE,

  impl = function(args, _)
    local util = require("zavigate.util")
    local args_normalized = util.normalize_arg(args[1])

    if args_normalized == nil then
      util.error("A direction must be provided", "zavigate move_tab")
      return
    end

    require("zavigate").move_tab(args_normalized)
  end,

  choices = {
    "Left",
    "Right",
  },
}

-- Misc Subcommands
---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.MoveFocus = {
  desc = "",
  nargs = NARGS.ONE,

  impl = function(args, _)
    local direction = require("zavigate.util").normalize_arg(args[1]) ---@type Zavigate.Util.Direction|nil

    if direction == nil then
      require("zavigate.util").error(
        string.format("Invalid direction: '%s' is not a valid argument", tostring(args[1])),
        "Zavigate MoveFocus"
      )
      return
    end

    require("zavigate").move_focus(direction)
  end,

  choices = {
    "Up",
    "Down",
    "Left",
    "Right",
  },
}

---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.Lock = {
  desc = "Lock Zellij",
  nargs = NARGS.NONE,

  impl = function(_, _)
    require("zavigate").lock()
  end,
}

---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.Unlock = {
  desc = "Unlock Zellij",
  nargs = NARGS.NONE,

  impl = function(_, _)
    require("zavigate").unlock()
  end,
}

---@param opts { fargs: string[] }
M.zavigate_cmd = function(opts)
  local fargs = opts.fargs
  local subcommand_key = fargs[1]

  local args = #fargs > 1 and vim.list_slice(fargs, 2, #fargs) or {}
  local subcommand = M.subcommand_tbl[subcommand_key]
  if not subcommand then
    require("zavigate.util").warn(
      string.format("Zavigate: Unknown Command: %s", tostring(subcommand_key)),
      "Zavigate"
    )
    return
  end

  subcommand.impl(args, opts)
end

local function setup_legacy()
  vim.api.nvim_create_user_command("Zavigate", M.zavigate_cmd, {
    nargs = NARGS.ONE_OR_MORE,
    desc = "Zavigate Description",
    complete = function(arg_lead, cmdline, _)
      -- Get the subcommand.
      local subcmd_key, subcmd_arg_lead = cmdline:match("^['<,'>]*Zavigate[!]*%s(%S+)%s(.*)$")
      if
        subcmd_key
        and subcmd_arg_lead
        and M.subcommand_tbl[subcmd_key]
        and M.subcommand_tbl[subcmd_key].choices ~= nil
      then
        -- The subcommand has completions. Return them.
        return require("zavigate.util").complete_from_list(
          M.subcommand_tbl[subcmd_key].choices,
          subcmd_arg_lead
        )
      end
      -- Check if cmdline is a subcommand
      if cmdline:match("^['<,'>]*Zavigate[!]*%s+%w*$") then
        -- Filter subcommands that match
        local subcommand_keys = vim.tbl_keys(M.subcommand_tbl)
        return vim
          .iter(subcommand_keys)
          :filter(function(key)
            return key:find(arg_lead) ~= nil
          end)
          :totable()
      end
    end,
  })
end

local function setup_cmdparse()
  local cmdparse = require("mega.cmdparse")

  local parser = cmdparse.ParameterParser.new({
    name = "Zavigate",
    help = "Zavigate Commands",
  })

  local subparsers = parser:add_subparsers({
    destination = "subcommand",
    help = "Zavigate Subcommands",
  })

  local keys = vim.tbl_keys(M.subcommand_tbl)
  table.sort(keys)

  for _, name in ipairs(keys) do
    local entry = M.subcommand_tbl[name] ---@type Zavigate.Commands.Subcommand

    local sub = subparsers:add_parser({
      name = name,
      help = entry.desc,
    })

    if entry.choices then
      sub:add_parameter({
        name = "args",
        choices = entry.choices,
        nargs = "*",
        help = "test123",
      })
    end

    sub:set_execute(function(data)
      local args = data.namespace.args or {}
      local opts = data.options or {}

      entry.impl(args, opts)
    end)
  end

  cmdparse.create_user_command(parser)
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
