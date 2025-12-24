---@class Zavigate.Commands
local M = {}

---@type table<string, Zavigate.Commands.Subcommand>
M.subcommand_tbl = {}

---@enum NArgs
local Nargs = {
  None = "0",
  One = "1",
  Many = "*",
  ZeroOrOne = "?",
  OneOrMore = "+",
}

-- Pane Subcommands
M.subcommand_tbl.NewPane = {
  desc = "Opens a new Zellij pane in the specified direction.",
  nargs = Nargs.Many,

  impl = function(args, _)
    local direction = require("zavigate.util").normalize_arg(args[1]) ---@type DirectionDR|nil
    require("zavigate").new_pane(direction)
  end,

  complete = function(subcmd_arg_lead)
    return require("zavigate.util").complete_from_list({
      "Down",
      "Right",
      "Floating",
    }, subcmd_arg_lead)
  end,
}

M.subcommand_tbl.ClosePane = {
  desc = "",
  nargs = Nargs.None,

  impl = function(_, _)
    require("zavigate").close_pane()
  end,
}

M.subcommand_tbl.MovePane = {
  desc = "",
  nargs = Nargs.One,

  impl = function(args, _)
    local direction = require("zavigate.util").normalize_arg(args[1]) ---@type Direction|nil

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

M.subcommand_tbl.ToggleFloatingPanes = {
  desc = "",
  nargs = Nargs.None,

  impl = function(_, _)
    require("zavigate").toggle_floating_panes()
  end,
}

M.subcommand_tbl.TogglePaneFullscreen = {
  desc = "",
  nargs = Nargs.None,

  impl = function(_, _)
    require("zavigate").toggle_pane_fullscreen()
  end,
}

-- Tab Subcommands

-- Misc Subcommands
M.subcommand_tbl.MoveFocus = {
  desc = "",
  nargs = Nargs.One,

  impl = function(args, _)
    local direction = require("zavigate.util").normalize_arg(args[1]) ---@type Direction|nil

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
  end

  subcommand.impl(args, opts)
end

function M.setup()
  print("Zavigate Command Setup Called")
  vim.api.nvim_create_user_command("Zavigate", M.zavigate_cmd, {
    nargs = Nargs.OneOrMore,
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
