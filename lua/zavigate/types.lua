---@class Zavigate.Plugin
---plugin entry point
---@field setup fun(opts: Zavigate.Config.Options.User) setup the plugin with the user options

---@class Zavigate.Keymaps
---keymap registration
---@field setup fun(opts: Zavigate.Config.Options.User) setup keymaps based on user configuration

---@class Zavigate.Keymaps.Bind
---defines a single keymap binding
---@field keymap string
---@field command string|function
---@field mode string|string[]
---@field desc string
---@field opts? table

---@class Zavigate.Core
---core pane and tab integrations
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

---@class Zavigate.Config
---@field options Zavigate.Config.Options merged user and default options
---@field setup function setup config and user options

---@class Zavigate.Config.Options
---@field disable_keymaps boolean whether the default zaivgate keymaps should be disabled (merged from user/default options)

---@class Zavigate.Config.Options.Defaults: Zavigate.Config.Options
---@class Zavigate.Config.Options.User: Zavigate.Config.Options

---@class Zavigate.Commands
---@field setup function
---@field subcommand_tbl table<string, Zavigate.Commands.Subcommand>
---@field zavigate_cmd function

---@class Zavigate.Commands.Subcommand
---@field desc string command description
---@field nargs NArgsValue number of arguments
---@field impl fun(args: string[], opts: table) command implementation
---@field complete? fun(subcmd_arg_lead: string): string[] (optional) command completion callback

---@class Zavigate.Health
---@field check function runs a vim health check on zavigate.nvim

---@alias Zavigate.Util.Direction
---| '"left"'
---| '"right"'
---| '"up"'
---| '"down"'

---@alias Zavigate.Util.DirectionDR
---| '"right"'
---| '"down"'

---@alias NArgsValue
---| "0" -- none
---| "1" -- exactly 1
---| "*" -- any number (0+)
---| "?" -- 0 or 1
---| "+" -- 1 or more
