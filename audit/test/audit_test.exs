defmodule AuditTest do
  use ExUnit.Case
  doctest Audit

  test "greets the world" do
    assert Audit.hello() == :world
  end
end
