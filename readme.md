# zavigate.nvim

**zavigate** is a Neovim plugin that integrates with **Zellij** allowing for easy pane creation, navigation and
layout management all from inside Neovim.

--

## Requirements
- Neovim 0.9+ (may work on <0.9 but has not been tested)
- Zellij
- Zellij must be running in the current terminal session (otherwise certain features are disabled)

## Installation
Install using your preferred plugin manager.

e.g. With `lazy.nvim`:
```lua
return {
    "chef-nate/zavigate.nvim",
    opts = {},
}
```

### Customization
All opts as well as their defaults as below:

```lua
opts = {
    disable_keymaps = false ---@type boolean Disables the default keymaps
}
```

--

## Features

## Commands
Neovim Command line functionality is exposed through the ```:Zavigate``` user command via subcommands.

General Form
```vim
:Zavigate <subcommand> [arguments]
```

All Commands:
```vim
""Panes
:Zavigate NewPane Direction|Opts|None
:Zavigate ClosePane
:Zavigate MovePane Direction
:Zavigate ToggleFloatingPanes
:Zavigate TogglePaneFullscreen
""Tabs
""Misc
:Zavigate MoveFocus Direction
```

The underlying function these commands call are exposed, so that they can be called from lua by
```require("zavigate").<function>()```

All Functions:
```lua
-- Panes
.new_pane(direction|opts|none)
.close_pane()
.move_pane(direction)
.toggle_floating_panes()
.toggle_pane_fullscreen()
-- Tabs
-- Misc
.move_focus(direction)
```
## Examples
```:Zavigate NewPane``` also supports passing command line arguments instead of just a direction. e.g. to have **btm** open in a floating pane:
```vim
:Zavigate NewPane --floating --close-on-exit -- btm
