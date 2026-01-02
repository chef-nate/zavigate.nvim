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
---@field complete? fun(subcmd_arg_lead: string): string[] Completion callback

---@alias NArgsValue
---| "0" -- none
---| "1" -- exactly 1
---| "*" -- any number (0+)
---| "?" -- 0 or 1
---| "+" -- 1 or more

---@type table<string, Zavigate.Commands.Subcommand>
M.subcommand_tbl = {}

---@type table<string, NArgsValue>
local NARGS = {
  NONE = "0",
  ONE = "1",
  MANY = "*",
  ZERO_OR_ONE = "?",
  ONE_OR_MORE = "+",
}

-- Pane Subcommands
---@type Zavigate.Commands.Subcommand
M.subcommand_tbl.NewPane = {
  desc = "Opens a new Zellij pane in the specified direction.",
  nargs = NARGS.MANY,

  impl = function(args, _)
    local args_normalized = require("zavigate.util").normalize_fargs(args)
    require("zavigate").new_pane(args_normalized)
  end,

  complete = function(subcmd_arg_lead)
    return require("zavigate.util").complete_from_list({
      "Down",
      "Right",
      "Floating",
      "Any",
    }, subcmd_arg_lead)
  end,
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

  complete = function(subcmd_arg_lead)
    return require("zavigate.util").complete_from_list({
      "Up",
      "Down",
      "Left",
      "Right",
    }, subcmd_arg_lead)
  end,
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

  complete = function(subcmd_arg_lead)
    return require("zavigate.util").complete_from_list({
      "Up",
      "Down",
      "Left",
      "Right",
    }, subcmd_arg_lead)
  end,
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

function M.setup()
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
        and M.subcommand_tbl[subcmd_key].complete
      then
        -- The subcommand has completions. Return them.
        return M.subcommand_tbl[subcmd_key].complete(subcmd_arg_lead)
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

return M
