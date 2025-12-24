local core ---@type Zavigate.Core
local calls

describe("zavigate core", function()
  -- stub zellij_action so we can test the command it would have executed
  before_each(function()
    calls = {}

    local utils = require("zavigate.util")

    stub(utils, "zellij_action", function(...)
      calls = ...
    end)

    package.loaded["zavigate.core"] = nil
    core = require("zavigate.core")
  end)

  -- run tests
  -- (1)
  it("testing: 'core.toggle_floating_panes()'", function()
    core.toggle_floating_panes()

    assert.same({
      "toggle-floating-panes",
    }, calls)
  end)

  --(2)
  it('testing: core.move_focus("down")', function()
    core.move_focus("down")

    assert.same({ "move-focus", "down" }, calls)
  end)

  --(3)
  it('testing: core.move_focus("Down")', function()
    core.move_focus("Down")

    assert.same({ "move-focus", "down" }, calls)
  end)
end)
