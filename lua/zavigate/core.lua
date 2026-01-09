---@mod zavigate.core

---@class Zavigate.Core
---core pane and tab integrations
---@field new_pane fun(direction_or_opts?:Zavigate.Util.DirectionDR|string[]): nil
---@field close_pane fun(): nil
---@field rename_pane fun(name?: string): nil
---@field resize_pane fun(direction: Zavigate.Util.Direction): nil
---@field toggle_floating_panes fun(): nil
---@field toggle_pane_fullscreen fun(): nil
---@field new_tab fun(): nil
---@field close_tab fun(): nil
---@field rename_tab fun(name?: string): nil
---@field move_tab fun(): nil
---@field move_focus fun(direction: Zavigate.Util.Direction): nil
---@field unlock fun(): nil
---@field lock fun(): nil
local M = {}

-- Pane Commands

---@param args string[]
function M.new_pane(args)
  local util = require("zavigate.util")

  local cwd = vim.fn.shellescape(vim.fn.getcwd())
  local shell = vim.env.SHELL

  local function spawn_floating_pane()
    util.zellij_action({
      "new-pane",
      "--close-on-exit",
      "--floating",
      "--cwd",
      cwd,
      "--",
      shell,
    })
  end

  if #args == 0 then
    spawn_floating_pane()
    return
  end

  if
    #args > 1
    or not util.validate_against_table(util.valid_selection_new_pane, string.lower(args[1]))
  then
    --check if they have passed in a shell command starting with '-'
    local first_char = args[1]:sub(1, 1)
    if first_char == "-" then
      -- presumably this is a shell command so we will pass them on
      local command = { "new-pane" }
      vim.list_extend(command, args)
      util.zellij_action(command)
    end
    return
  end

  local selection = string.lower(args[1])

  if selection == "floating" then
    spawn_floating_pane()
    return
  end

  if selection == "any" then
    util.zellij_action({
      "new-pane",
      "--close-on-exit",
      "--cwd",
      cwd,
      "--",
      shell,
    })
  end

  util.zellij_action({
    "new-pane",
    "--close-on-exit",
    "--direction",
    selection,
    "--cwd",
    cwd,
    "--",
    shell,
  })
end

function M.close_pane()
  require("zavigate.util").zellij_action({ "close-pane" })
end

---@param name string|nil
function M.rename_pane(name)
  ---@param n string
  local apply_rename = function(n)
    require("zavigate.util").zellij_action({ "rename-pane", n })
  end

  name = name or ""
  if name == "" then
    vim.ui.input({ prompt = "New pane name: " }, apply_rename)
    return
  end

  apply_rename(name)
end

function M.resize_pane() end

---@param direction Zavigate.Util.Direction
function M.move_pane(direction)
  local util = require("zavigate.util")

  direction = string.lower(direction)

  if not util.validate_against_table(util.valid_directions_lrud, direction, false) then
    return
  end

  util.zellij_action({
    "move-pane",
    direction,
  })
end

function M.toggle_floating_panes()
  local util = require("zavigate.util")
  util.zellij_action({ "toggle-floating-panes" })
end

function M.toggle_pane_fullscreen()
  local util = require("zavigate.util")
  util.zellij_action({ "toggle-fullscreen" })
end

-- Tab Commands
function M.new_tab()
  local util = require("zavigate.util")
  util.zellij_action({ "new-tab" })
end

function M.close_tab() end

---@param name string|nil
function M.rename_tab(name)
  ---@param n string
  local apply_rename = function(n)
    require("zavigate.util").zellij_action({ "rename-tab", n })
  end

  name = name or ""
  if name == "" then
    vim.ui.input({ prompt = "New tab name: " }, apply_rename)
    return
  end

  apply_rename(name)
end

function M.move_tab() end

-- Misc Commands

---@param direction Zavigate.Util.Direction
function M.move_focus(direction)
  local util = require("zavigate.util")

  direction = string.lower(direction)

  if not util.validate_against_table(util.valid_directions_lrud, direction, false) then
    return
  end

  -- (1) try Neovim window navigation
  local init_winnr = vim.fn.winnr()
  vim.cmd("wincmd " .. util.hjkl_map[direction])

  if vim.fn.winnr() ~= init_winnr then
    return
  end

  -- (2) try zellij tab navigation (left/right only)
  if util.validate_against_table(util.valid_directions_lr, direction, false) then
    util.zellij_action({ "move-focus-or-tab", direction })
    return
  end

  -- (3) fallback to zellij pane navigation
  util.zellij_action({ "move-focus", direction })
end

function M.lock()
  local util = require("zavigate.util")
  util.zellij_action({ "switch-mode", "locked" })
end

function M.unlock()
  local util = require("zavigate.util")
  util.zellij_action({ "switch-mode", "normal" })
end

return M
