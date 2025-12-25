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

  --(4) test new_pane custom opts functionality
  it('testing core.new_pane({"--floating", "--close-on-exit", "-- btm"})', function()
    core.new_pane({ "--floating", "--close-on-exit", "-- btm" })

    assert.same({ "new-pane", "--floating", "--close-on-exit", "-- btm" }, calls)
  end)

  --(5) test new pane doesnt work when an invalid single arg is provided
  it("testing new pane with invalid single arg", function()
    core.new_pane({ "invalid_option" })

    assert.are_same({}, calls)
  end)

  --(6) test new pane doesnt work when an invalid multiple arg (>1) is provided
  it("testing new pane with invalid multiple arg", function()
    core.new_pane({ "invalid_option", "invalid_option_2" })

    assert.are_same({}, calls)
  end)
end)
