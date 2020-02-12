defmodule BleacherReportApp.Schema.UserBehavior do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @all_attributes [
    :action,
    :type,
    :reaction_type,
    :content_id,
    :user_id
  ]

  schema "user_behaviors" do
    field(:action, UserBehaviorActionEnum)
    field(:type, :string)
    field(:reaction_type, :string)
    field(:content_id, Ecto.UUID)
    field(:user_id, Ecto.UUID)

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = user_behavior, attrs) do
    user_behavior
    |> cast(attrs, @all_attributes)
    |> validate_required(@all_attributes)
  end
end
