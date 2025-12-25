---@class Zavigate.Keymaps
---@field setup function
local M = {}

-- Bind | Command | Mode | Opts
---@type Zavigate.Keymap.Binding[]
local default_mappings = {
  -- Alt Key Shortcut Pane Keymaps
  {
    keymap = "<A-h>",
    command = "<cmd>Zavigate MoveFocus Left<cr>",
    mode = "n",
    desc = "Move Focus: Left",
    opts = { silent = true },
  },
  {
    keymap = "<A-j>",
    command = "<cmd>Zavigate MoveFocus Down<cr>",
    mode = "n",
    desc = "Move Focus: Down",
    opts = { silent = true },
  },
  {
    keymap = "<A-k>",
    command = "<cmd>Zavigate MoveFocus Up<cr>",
    mode = "n",
    desc = "Move Focus: Up",
    opts = { silent = true },
  },
  {
    keymap = "<A-l>",
    command = "<cmd>Zavigate MoveFocus Right<cr>",
    mode = "n",
    desc = "Move Focus: Right",
    opts = { silent = true },
  },
  {
    keymap = "<A-f>",
    command = "<cmd>Zavigate ToggleFloatingPanes<cr>",
    mode = "n",
    desc = "Toggle Floating Pane Visibility",
    opts = { silent = true },
  },
  {
    keymap = "<A-x>",
    command = "<cmd>Zavigate ClosePane<cr>",
    mode = "n",
    desc = "Close Active Pane",
    opts = { silent = true },
  },
  {
    keymap = "<A-n>",
    command = "<cmd>Zavigate NewPane Any<cr>",
    mode = "n",
    desc = "Create a New Pane",
    opts = { silent = true },
  },
  {
    keymap = "<A-t>",
    command = "<cmd>Zavigate NewTab<cr>",
    mode = "n",
    desc = "Create a New Zellij Tab",
    opts = { silent = true },
  },

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

---@param opts Zavigate.Config.UserOptions
function M.setup(opts)
  if not opts.disable_keymaps then
    M.setup_defaults()
  end
end

function M.setup_defaults()
  for _, map in ipairs(default_mappings) do
    vim.keymap.set(
      map.mode,
      map.keymap,
      map.command,
      vim.tbl_deep_extend("force", map.opts or {}, { desc = map.desc })
    )
  end
end

return M
