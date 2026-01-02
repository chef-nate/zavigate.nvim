---@mod zavigate.health

---@class Zavigate.Health
---Health checks for zavigate.nvim
---@field check fun():nil Runs ':checkhealth zavigate'
local M = {}

---@return boolean
local function zellij_installed()
  if vim.fn.executable("zellij") == 1 then
    return true
  end

  return false
end

---@return boolean
local function zellij_running()
  if vim.env.ZELLIJ ~= nil then
    return true
  end

  return false
end

---@return boolean
local function minimium_nvim_installed()
  if vim.fn.has("nvim-0.9") == 1 then
    return true
  end

  return false
end

---@return boolean
local function zellij_autolock_installed()
  ---TODO: Implement (stub)
  -- query zellij for zellij plugins directory
  local check_obj = vim.system({ "zellij", "setup", "--check" }, { text = true }):wait(1000) ---@type vim.SystemCompleted
  -- parse output for plugins
  local plugin_dir = check_obj.stdout:match('%[PLUGIN DIR%]%s*:%s*"?([^"\r\n]+)"?')
  -- search directory for autolock
  return false
end

function M.check()
  vim.health.start("zavigate.nvim")

  -- Check min nvim version
  if minimium_nvim_installed() then
    vim.health.ok("Neovim >= 0.9.0")
  else
    vim.health.error("Neovim >= 0.9.0 is required")
  end

  -- Check if Zellij is installed
  if zellij_installed() then
    vim.health.ok("zellij executable found")

    -- Check if zellij is running
    if zellij_running() then
      vim.health.ok("Running inside of Zellij")
    else
      vim.health.warn("Not running inside of Zellij, some functionality has been disabled")
    end

    -- Check if autolock is installed
    -- if zellij_autolock_installed() then
    --   vim.health.ok("Zellij autolock plugin is installed")
    -- else
    --   vim.health.error("Zellij autolock plugin is required")
    -- end
  else
    vim.health.error("Zellij executable not found")
  end
end

return M
