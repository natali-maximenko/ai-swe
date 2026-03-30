defmodule Audit.AuditEventTest do
  use ExUnit.Case, async: true

  alias Audit.AuditEvent
  alias Audit.Repo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "inserts and reads audit event by id" do
    attrs = %{
      operation: "insert",
      entity_type: "user",
      entity_id: "123",
      metadata: %{"source" => "test"},
      payload: %{"name" => "Alice"}
    }

    changeset = AuditEvent.changeset(%AuditEvent{}, attrs)
    assert {:ok, created} = Repo.insert(changeset)
    id = created.id

    assert %AuditEvent{id: ^id, entity_id: "123"} = Repo.get(AuditEvent, created.id)
  end
end
