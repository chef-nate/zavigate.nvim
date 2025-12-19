local M = {}

-- Pane Commands

---@param direction Direction|nil
function M.new_pane(direction)
  local util = require("zavigate.util")

  local cwd = vim.fn.shellescape(vim.fn.getcwd())
  local shell = vim.env.SHELL

  if direction == nil then
    util.zellij_action({
      "new-pane",
      "--close-on-exit",
      "--floating",
      "--cwd",
      cwd,
      "--",
      shell,
    })
    return
  end

  util.validate_direction_lrud(direction)

  util.zellij_action({
    "new-pane",
    "--close-on-exit",
    "--direction",
    direction,
    "--cwd",
    cwd,
    "--",
    shell,
  })
end

function M.close_pane()
  require("zavigate.util").zellij_action({ "close-pane" })
end

function M.rename_pane() end

function M.resize_pane() end

---@param direction Direction
function M.move_pane(direction)
  local util = require("zavigate.util")

  util.valid_directions_lrud(direction)

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
function M.new_tab() end

function M.close_tab() end

function M.rename_tab() end

function M.move_tab() end

-- Misc Commands

---@param direction Direction
function M.move_focus(direction)
  local util = require("zavigate.util")

  util.validate_direction_lrud(direction)

  -- (1) try Neovim window navigation
  local init_winnr = vim.fn.winnr()
  vim.cmd("wincmd " .. util.hjkl_map[direction])

  if vim.fn.winnr() ~= init_winnr then
    return
  end

  -- (2) try zellij tab navigation (left/right only)
  if util.valid_directions_lr[direction] then
    util.zellij_action({ "move-focus-or-tab", direction })
    return
  end

  -- (3) fallback to zellij pane navigation
  util.zellij_action({ "move-focus", direction })
end

function M.lock() end

function M.unlock() end

return M
