defmodule Audit.Migrations do
  @moduledoc """
  Public migration helpers for installing audit storage.
  """

  use Ecto.Migration

  @doc """
  Creates the `audit_events` table.
  """
  def up do
    create table(:audit_events, primary_key: false) do
      add(:id, :binary_id, primary_key: true, null: false)
      add(:operation, :string, null: false)
      add(:entity_type, :string, null: false)
      add(:entity_id, :text, null: false)
      add(:metadata, :map, null: false, default: %{})
      add(:payload, :map)

      timestamps(updated_at: false, type: :utc_datetime_usec)
    end
  end

  @doc """
  Drops the `audit_events` table.
  """
  def down do
    drop(table(:audit_events))
  end
end
