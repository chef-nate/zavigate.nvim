---@class Zavigate.Health
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

M.check = function()
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
  else
    vim.health.error("zellij executable not found")
  end

  -- Check if zellij is running
  if zellij_running() then
    vim.health.ok("Running inside of zellij")
  else
    vim.health.warn("Not running inside of zellij, some functionality has been disabled")
  end
end

return M
