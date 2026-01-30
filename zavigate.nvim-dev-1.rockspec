package = "zavigate.nvim"

version = "dev-1"

source = {
  url = "git+https://github.com/chef-nate/zavigate.nvim.git",
}

description = {
  homepage = "https://github.com/chef-nate/zavigate.nvim",
  labels = { "neovim", "neovim-plugin", "neovim-zellij-plugin", "zellij" },
  license = "GPL-3.0-or-later",
  summary = "Zellij integration for Neovim supporting window navigation and workspace management",
}

dependencies = {
  "lua >= 5.1",
  "mega.cmdparse",
  "mega.logging",
}

test_dependencies = {
  "busted >= 2.0, < 3.0",
  "lua >= 5.1",
}

build = {
  type = "builtin",
  modules = {
    ["zavigate"] = "lua/zavigate/init.lua",
    ["zavigate.commands"] = "lua/zavigate/commands.lua",
    ["zavigate.config"] = "lua/zavigate/config.lua",
    ["zavigate.core"] = "lua/zavigate/core.lua",
    ["zavigate.health"] = "lua/zavigate/health.lua",
    ["zavigate.keymaps"] = "lua/zavigate/keymaps.lua",
    ["zavigate.types"] = "lua/zavigate/types.lua",
    ["zavigate.util"] = "lua/zavigate/util.lua",
  },
}

rockspec_format = "3.0"
