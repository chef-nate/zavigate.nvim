--- init.lua
---@class Zavigate.Plugin
---@field setup function setup the plugin with the user options

-- config.lua
---@class Zavigate.Config
---@field defaults Zavigate.Config.DefaultOptions default plugin options
---@field options Zavigate.Config.UserOptions merged user and default options
---@field setup function setup the plugin configuration

---@class Zavigate.Config.DefaultOptions
---@field disable_keymaps boolean whether the default zaivgate keymaps should be disabled (merged from user/default options)

---@class Zavigate.Config.UserOptions
---@field disable_keymaps? boolean

-- core.lua
---@class Zavigate.Core
---@field new_pane function
---@field close_pane function
---@field rename_pane function
---@field resize_pane function
---@field toggle_floating_panes function
---@field toggle_pane_fullscreen function
---@field new_tab function
---@field close_tab function
---@field rename_tab function
---@field move_tab function
---@field move_focus function
---@field unlock function
---@field lock function

-- commands.lua

---@class Zavigate.Commands
---@field setup function
---@field subcommand_tbl table<string, Zavigate.Commands.Subcommand>
---@field zavigate_cmd function

---@class Zavigate.Commands.Subcommand
---@field desc string command description
---@field nargs NArgsValue number of arguments
---@field impl fun(args: string[], opts: table) command implementation
---@field complete? fun(subcmd_arg_lead: string): string[] (optional) command completion callback

-- keymaps.lua
---@class Zavigate.Keymap.Binding
---@field keymap string
---@field command string|function
---@field mode string|string[]
---@field desc string
---@field opts? table

-- misc...
---@alias Direction
---| '"left"'
---| '"right"'
---| '"up"'
---| '"down"'

---@alias DirectionDR
---| '"right"'
---| '"down"'

---@alias NArgsValue
---| "0" -- none
---| "1" -- exactly 1
---| "*" -- any number (0+)
---| "?" -- 0 or 1
---| "+" -- 1 or more
