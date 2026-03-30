defmodule Audit.AuditEvent do
  @moduledoc """
  Base audit event schema stored in `audit_events`.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "audit_events" do
    field(:operation, :string)
    field(:entity_type, :string)
    field(:entity_id, :string)
    field(:metadata, :map)
    field(:payload, :map)

    timestamps(updated_at: false)
  end

  @required_fields [:operation, :entity_type, :entity_id, :metadata, :payload]

  def changeset(audit_event, attrs) do
    audit_event
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
