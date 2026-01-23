---@mod zavigate.keymaps

---@class Zavigate.Keymaps
---Keymap registration
---@field setup fun(opts: Config.Options.User): nil Setup keymaps based on user configuration
---@field setup_default_mappings fun(): nil Register default mappings
local M = {}

---@class Zavigate.Keymaps.Bind
---Defines a single keymap binding
---@field keymap string
---@field command string|function
---@field mode string|string[]
---@field desc string
---@field opts? table

---@type Zavigate.Keymaps.Bind[]
local default_mappings = {
  -- Alt Key Shortcut Pane Keymaps
  {
    keymap = "<A-h>",
    command = "<cmd>Zavigate MoveFocus Left<cr>",
    mode = "",
    desc = "Move Focus: Left",
    opts = { silent = true },
  },
  {
    keymap = "<A-j>",
    command = "<cmd>Zavigate MoveFocus Down<cr>",
    mode = "",
    desc = "Move Focus: Down",
    opts = { silent = true },
  },
  {
    keymap = "<A-k>",
    command = "<cmd>Zavigate MoveFocus Up<cr>",
    mode = "",
    desc = "Move Focus: Up",
    opts = { silent = true },
  },
  {
    keymap = "<A-l>",
    command = "<cmd>Zavigate MoveFocus Right<cr>",
    mode = "",
    desc = "Move Focus: Right",
    opts = { silent = true },
  },
  {
    keymap = "<A-f>",
    command = "<cmd>Zavigate ToggleFloatingPanes<cr>",
    mode = "",
    desc = "Toggle Floating Pane Visibility",
    opts = { silent = true },
  },
  {
    keymap = "<A-x>",
    command = "<cmd>Zavigate ClosePane<cr>",
    mode = "",
    desc = "Close Active Pane",
    opts = { silent = true },
  },
  {
    keymap = "<A-n>",
    command = "<cmd>Zavigate NewPane Any<cr>",
    mode = "",
    desc = "Create a New Pane",
    opts = { silent = true },
  },
  {
    keymap = "<A-t>",
    command = "<cmd>Zavigate NewTab<cr>",
    mode = "",
    desc = "Create a New Zellij Tab",
    opts = { silent = true },
  },
}

---@type Zavigate.Keymaps.Bind[]
local extended_mappings = {
  -- Ctrl-p Pane Keymaps
  {
    keymap = "<C-p>",
    command = "",
    mode = "n",
    desc = "Zellij Panes",
    opts = { silent = true },
  },
  {
    keymap = "<C-p>h",
    command = "<cmd>Zavigate MoveFocus Left<cr>",
    mode = "n",
    desc = "Move Focus: Left",
  },
  {
    keymap = "<C-p>j",
    command = "<cmd>Zavigate MoveFocus Down<cr>",
    mode = "n",
    desc = "Move Focus: Down",
  },
  {
    keymap = "<C-p>k",
    command = "<cmd>Zavigate MoveFocus Up<cr>",
    mode = "n",
    desc = "Move Focus: Up",
  },
  {
    keymap = "<C-p>l",
    command = "<cmd>Zavigate MoveFocus Right<cr>",
    mode = "n",
    desc = "Move Focus: Right",
  },
  {
    keymap = "<C-p>x",
    command = "<cmd>Zavigate ClosePane<cr>",
    mode = "n",
    desc = "Close Active Pane",
  },
  {
    keymap = "<C-p>d",
    command = "<cmd>Zavigate NewPane Down<cr>",
    mode = "n",
    desc = "New Pane: Down",
  },
  {
    keymap = "<C-p>r",
    command = "<cmd>Zavigate NewPane Right<cr>",
    mode = "n",
    desc = "New Pane: Right",
  },
  {
    keymap = "<C-p>f",
    command = "<cmd>Zavigate TogglePaneFullscreen<cr>",
    mode = "n",
    desc = "Toggle Pane Fullscreen",
  },
  {
    keymap = "<C-p>c",
    command = "<cmd>Zavigate RenamePane<cr>",
    mode = "n",
    desc = "Rename Active Pane",
  },
}

---@param opts Config.Options.User
---@return nil
function M.setup(opts)
  if not opts.disable_keymaps then
    -- default keymaps allways enabled
    M.setup_default_mappings()

    -- if extended mappings then also assign...
    if opts.keymap_preset == "extended" then
      M.setup_extended_mappings()
    end

    if opts.autolock_zellij then
      M.setup_autolock_autocmd()
    end
  end
end

---@return nil
function M.setup_default_mappings()
  for _, map in ipairs(default_mappings) do
    vim.keymap.set(
      map.mode,
      map.keymap,
      map.command,
      vim.tbl_deep_extend("force", map.opts or {}, { desc = map.desc })
    )
  end
end

---@return nil
function M.setup_extended_mappings()
  for _, map in ipairs(extended_mappings) do
    vim.keymap.set(
      map.mode,
      map.keymap,
      map.command,
      vim.tbl_deep_extend("force", map.opts or {}, { desc = map.desc })
    )
  end
end

---@return nil
function M.setup_autolock_autocmd()
  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("zavigate_lock", {}),
    callback = function()
      require("zavigate").lock()
    end,
  })

  vim.api.nvim_create_autocmd({ "FocusLost", "VimLeave" }, {
    group = vim.api.nvim_create_augroup("zavigate_unlock", {}),
    callback = function()
      require("zavigate").unlock()
    end,
  })
end

return M
