defmodule BleacherReportAppWeb.Router do
  use BleacherReportAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    post(
      "api/reaction",
      BleacherReportAppWeb.UserController,
      :handle_fire_action,
      as: :user_content_reaction
    )

    get(
      "api/reaction_counts/:content_id",
      BleacherReportAppWeb.UserController,
      :count_fire_action,
      as: :user_count
    )
  end

  scope "/", BleacherReportAppWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BleacherReportAppWeb do
  #   pipe_through :api
  # end
end
