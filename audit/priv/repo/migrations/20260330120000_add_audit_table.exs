defmodule Audit.Repo.Migrations.AddAuditTable do
  use Ecto.Migration

  def up do
    Audit.Migrations.up()
  end

  def down do
    Audit.Migrations.down()
  end
end
