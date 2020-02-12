defmodule BleacherReportApp.Repo.Migrations.CreateUserBehavior do
  use Ecto.Migration

  def up do
    create table(:user_behaviors, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:action, :string, null: false)
      add(:type, :string, null: false)
      add(:reaction_type, :string, null: false)
      add(:content_id, :binary_id, null: false)
      add(:user_id, :binary_id, null: false)
      timestamps()
    end
  end

  def down do
    drop(table(:user_behaviors))
  end
end
