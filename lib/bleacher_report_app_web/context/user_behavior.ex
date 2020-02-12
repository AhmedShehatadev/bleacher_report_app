defmodule BleacherReportAppWeb.Context.UserBehavior do
  alias BleacherReportApp.Schema.UserBehavior

  alias BleacherReportAppWeb.UserFireCounts.Cache

  import Ecto.Query

  alias BleacherReportApp.Repo

  def fire_action_add(user_behavior_params) do
    changeset = UserBehavior.changeset(%UserBehavior{}, user_behavior_params)

    case Repo.insert(changeset) do
      {:ok, user_content_behavior} ->
        {:ok, user_content_behavior}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def fire_action_remove(user_behavior_params) do
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise)
    from(ub in UserBehavior,
      where:
        ub.user_id == ^user_behavior_params["user_id"] and
          ub.content_id == ^user_behavior_params["content_id"] and ub.action == "add",
      select: ub
    )
    |> Repo.all()
    |> List.first()
    |> remove_fire(user_behavior_params)
    |> IO.inspect(label: "x2asass")
  end

  defp remove_fire(changeset, user_behavior_params) when is_nil(changeset),
    do: {:no_changset_to_update, "No fire action added to remove it"}

  defp remove_fire(changeset, user_behavior_params) do
    changeset
    |> UserBehavior.changeset(user_behavior_params)
    |> Repo.update()
  end

  defp update_counts(content_id, counts) do
  end

  def count_fires(content_id) do
    IO.inspect(Cache.get_user_counts(content_id), label: "genserver")

    case Cache.get_user_counts(content_id) do
      nil ->
        query =
          from userbehavior in UserBehavior,
            where: userbehavior.content_id == ^content_id and userbehavior.action == "add",
            select: userbehavior

        counts = Repo.aggregate(query, :count)

        Cache.set_user_counts(content_id, counts)
        counts

      counts ->
        counts
    end
  end
end
