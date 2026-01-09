# Requirements
- Neovim 0.9+ (may work on <0.9 but has not been tested)
- Zellij
- Zellij must be running in the current terminal session (otherwise certain features are disabled)
- [zellij-autolock](https://github.com/fresh2dev/zellij-autolock) must be installed

# Installation
## lazy.nvim
```lua
return {
    "chef-nate/zavigate.nvim",
    opts = {},
}
```

## Other
If using a different package manager, ensure zavigate.nvim is installed, and setup is called. e.g.
```lua
require("zavigate").setup()
```

# Configuration
## Keymaps

# Commands
All zavigate.nvim user commands use the 'Zavigate' prefix with functionality being exposed through subcommands.
```vim
:Zavigate <subcommand> [argument(s)]
```

For example, to spawn a new zellij pane to the right of the active pane, the below command would be used:
```vim
:Zavigate NewPane right
```

## NewPane
```vim
:Zavigate NewPane {direction}|{opts}|{none}
```
Spawns a new Zellij pane.
If `{direction}` is given, a pane is created in that direction running the default `$SHELL`.

Instead of a direction, `Floating` may be passed in to create a floating pane.

Alternatively, you may omit a direction entirely and instead pass raw `zellij action new-pane` options.

### Arguments
`{direction}`
'Right' | 'Down'

`Floating`
Spawn a floating pane.

`{opts}`
Options passed through to `zellij action new-pane` (see `zellij action new-pane --help` for reference).

### Usage
```vim
"(1) Spawn a new pane to the right of the active pane:
:Zavigate NewPane Right

"(2) Spawn a floating pane:
:Zavigate NewPane Floating

"(3) Spawn 'top' tui program in a new pane below the active one, and make the pane close on exit:
:Zavigate NewPane --direction down --close-on-exit -- top

"(4) Spawn a new pane running 'zsh' in a floating pane using new-pane opts:
:Zavigate NewPane --floating --close-on-exit -- zsh
```

### Lua
```lua
require("zavigate").new_pane(direction_or_opts_or_none) ---@param direction_or_opts_or_none string|string[]|nil
```

## ClosePane
```vim
:Zavigate ClosePane
```

Closes the currently focussed Zellij pane.
### Lua
```lua
require("zavigate").close_pane()
```

## MovePane
```vim
:Zavigate MovePane {direction}
```

Moves the focussed Zellij pane in the specified direction

### Arguments
`{direction}`
'Up' | 'Down' | 'Left' | 'Right'

### Usage
```vim
:Zelij MovePane Right
```

### Lua
```lua
require("zavigate").move_pane(direction) ---@param direction string
```

## ToggleFloatingPanes
```vim
:Zavigate ToggleFloatingPanes
```

Toggles the visibility of all floating panes.

### Lua
```lua
require("zavigate").toggle_floating_panes()
```

## TogglePaneFullscreen
```vim
:Zavigate TogglePaneFullscreen
```

Toggles the active pane between being fullscreen, and being tiled.

### Lua
```lua
require("zavigate").toggle_pane_fullscreen()
```

## RenamePane
```vim
:Zavigate RenamePane {string}|{none}
```

Renames the active pane to the name provided. If no name provided, a Neovim popup will prompt the user for a
name to input.

### Arguments
`{string}`
Any valid string.

`{none}`
nil.

### Usage
```vim
"(1) Renames the current pane to 'MyPaneName'
:Zavigate RenamePane MyPaneName

"(2) Prompts the user to enter a new name to rename the pane to
:Zavigate RenamePane
```

### Lua
```lua
require("zavigate").rename_pane(name_or_nil) ---@param name_or_nil string|nil
```

## NewTab
```vim
:Zavigate NewTab
```
Creates a new Zellij tab.

### Lua
```lua
require("zavigate").new_tab()
```

## RenameTab
```vim
:Zavigate RenameTab {string}|{none}
```

Renames the active Zellij tab to the name provided. If no name provided, a Neovim popup will prompt the user for a name
to input.

### Arguments
`{string}`
Any valid string.

`{none}`
nil.

### Usage
```vim
"(1) Renames the current tab to 'MyTabName'
:Zavigate RenameTab MyTabName

"(2) Prompts the user to enter a new name to rename the tab to
:Zavigate RenameTab
```
### Lua
```lua
require("zavigate").rename_tab(name_or_nil) ---@param name_or_nil string|nil
```

## MoveFocus
```vim
:Zavigate MoveFocus {direction}
```

The command first attempts to move focus within Neovim. If no further movement is possible, it then tries to shift focus
to the currently active Zellij pane. Finally, if multiple tabs are open and the active pane is already at the edge in
the requested direction, the focus moves to the adjacent tab in that direction.

### Arguments
`{direction}`
'Up' | 'Down' | 'Left' | 'Right'

### Usage
```vim
"(1) Moves the focus from the current pane, to the pane to the left of it
:Zavigate MoveFocus Left
```

### Lua
```lua
require("zavigate").move_focus(direction) ---@param direction string
```

## Lock
```vim
:Zavigate Lock
```

Locks Zellij.

### Lua
```lua
require("zavigate").lock()
```

## Unlock
```vim
:Zavigate Unlock
```

Unlocks Zellij.

### Lua
```lua
require("zavigate").unlock()
```
