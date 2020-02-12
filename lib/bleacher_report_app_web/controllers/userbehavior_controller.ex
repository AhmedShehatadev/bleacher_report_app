defmodule BleacherReportAppWeb.UserController do
  alias BleacherReportAppWeb.Context.UserBehavior, as: UserWrapper
  alias BleacherReportApp.Schema.UserBehavior

  alias BleacherReportAppWeb.ErrorView

  use BleacherReportAppWeb, :controller

  def handle_fire_action(conn, %{"action" => "add"} = params) do
    case UserWrapper.fire_action_add(params) do
      {:ok, user_content_behavior} ->
        conn
        |> put_status(:created)
        |> render(BleacherReportAppWeb.UserBehaviorView, "handle_fire_action.json",
          user_content_behavior: user_content_behavior
        )

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "error.json", changeset: changeset)
    end
  end

  def handle_fire_action(conn, %{"action" => "remove"} = params) do
    changeset = UserBehavior.changeset(%UserBehavior{}, params)

    case UserWrapper.fire_action_remove(params) do
      {:ok, user_content_behavior} ->
        conn
        |> put_status(:created)
        |> render(BleacherReportAppWeb.UserBehaviorView, "handle_fire_action.json",
          user_content_behavior: user_content_behavior
        )

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "error.json", changeset: changeset)

      {:no_changset_to_update, message} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "error.json", errors: message)
    end
  end

  def handle_fire_action(conn, %{"action" => _non_valid_type} = params) do
    conn
    |> put_status(404)
    |> render(ErrorView, "404.json", msg: "Undefined Route Action should be remove/add")
  end

  def count_fire_action(conn, params) do
    cont_id = params["content_id"]

    case UserWrapper.count_fires(cont_id) do
      counts ->
        conn
        |> put_status(:created)
        |> render(BleacherReportAppWeb.UserBehaviorView, "reaction_counts.json", %{
          counts: counts,
          content_id: cont_id
        })

      nil ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BleacherReportAppWeb.ChangesetView, "error.json",
          changeset: %{message: "no counts for this content_id"}
        )
    end
  end
end
