local M = {}

---@param opts Zavigate.UserOptions: plugin options
function M.setup(opts)
  require("zavigate.config").setup(opts)
end

-- Pane Commands

---@param direction Direction|nil
function M.new_pane(direction)
  require("zavigate.core").new_pane(direction)
end

function M.close_pane()
  require("zavigate.core").close_pane()
end

---@param direction Direction
function M.move_pane(direction)
  require("zavigate.core").move_pane(direction)
end

function M.toggle_floating_panes()
  require("zavigate.core").toggle_floating_panes()
end

function M.toggle_pane_fullscreen()
  require("zavigate.core").toggle_pane_fullscreen()
end

-- Tab Commands

-- Misc Commands
---@param direction Direction
function M.move_focus(direction)
  require("zavigate.core").move_focus(direction)
end

return M
