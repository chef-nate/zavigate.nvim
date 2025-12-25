# zavigate.nvim

**zavigate** is a Neovim plugin that integrates with **Zellij** allowing for easy pane creation, navigation and
layout management all from inside Neovim.

## Requirements
- Neovim 0.9+ (may work on <0.9 but has not been tested)
- Zellij
- Zellij must be running in the current terminal session (otherwise certain features are disabled)
- [zellij-autolock](https://github.com/fresh2dev/zellij-autolock) must be installed

## Installation
Install using your preferred plugin manager.

e.g. With `lazy.nvim`:
```lua
return {
    "chef-nate/zavigate.nvim",
    opts = {},
}
```

Additionally, zellij-autolock must also installed. To do so navigate to your Zellij config (by default found at
```~/.config/zellij/config.kdl```) and add zellij-autolock to your plugins:
```
plugins = {
    autolock location="https://github.com/fresh2dev/zellij-autolock/releases/latest/download/zellij-autolock.wasm" {
        triggers "nvim|vim|v|nv"
        watch_interval "1.0"
        watch_triggers "fzf|zoxide|atuin|atac"
    }
    //...
}
```

And then add it to the load plugins section:
```
load_plugins {
    autolock
    //...
}
```

### Customization
All opts as well as their defaults as below:

```lua
opts = {
    disable_keymaps = false ---@type boolean Disables the default keymaps
}
```

#### Default keymaps
| Key bind | Command | Description |
|----------|---------|-------------|
| <A-h> | :Zavigate MoveFocus Left |Move Focus: Left |
| <A-j> | :Zavigate MoveFocus Down |Move Focus: Down |
| <A-k> | :Zavigate MoveFocus Up |Move Focus: Up |
| <A-l> | :Zavigate MoveFocus Right |Move Focus: Right |
| <A-f> | :Zavigate ToggleFloatingPanes | Toggle Floating Pane Visibility |
| <A-x> | :Zavigate ClosePane | Close Active Pane |
| <A-n> | :Zavigate NewPane Any | Create a New Zellij Pane in whichever direction has the most space |
| <A-t> | :Zavigate NewTab | Create a New Zellij Tab |
| <C-p>h | :Zavigate MoveFocus Left |Move Focus: Left |
| <C-p>j | :Zavigate MoveFocus Down |Move Focus: Down |
| <C-p>k | :Zavigate MoveFocus Up |Move Focus: Up |
| <C-p>l | :Zavigate MoveFocus Right |Move Focus: Right |
| <C-p>x | :Zavigate ClosePane | Close Active Pane |
| <C-p>d | :Zavigate NewPane Down | Create a New Zellij Pane Downwards |
| <C-p>r | :Zavigate NewPane Right | Create a New Zellij Pane Rightwards |
| <C-p>f | :Zavigate TogglePaneFullscreen | Toggle Pane Fullscreen |
| <C-p>c | :Zavigate RenamePane| Rename the Active Pane |


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
:Zavigate NewPane Right|Down|Any|Floating|Opts|None
:Zavigate ClosePane
:Zavigate MovePane Direction
:Zavigate ToggleFloatingPanes
:Zavigate TogglePaneFullscreen
""Tabs
:Zavigate NewTab
""Misc
:Zavigate MoveFocus Direction
:Zavigate Lock
:Zavigate Unlock
```

The underlying functions these commands call are exposed, so that they can be called from lua by
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
.new_tab()
-- Misc
.move_focus(direction)
.lock()
.unlock()
```

## Examples
```:Zavigate NewPane``` also supports passing command line arguments instead of just a direction. e.g. to have **btm** open in a floating pane:
```vim
:Zavigate NewPane --floating --close-on-exit -- btm
