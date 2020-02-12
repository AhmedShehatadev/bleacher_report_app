defmodule BleacherReportAppWeb.UserFireCounts.Cache do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: :users_fire_counts_cache)
  end

  def init(_) do
    state = %{
      users_counts: %{}
    }

    {:ok, state}
  end

  def set_user_counts(content_id, counts) do
    GenServer.cast(
      :users_fire_counts_cache,
      {:set_user_counts, content_id, counts}
    )
  end

  def get_user_counts(content_id) do
    GenServer.call(:users_fire_counts_cache, {:get_user_counts, content_id})
  end

  # Callbacks

  def handle_call({:get_user_counts, content_id}, _from, state) do
    counts = get_in(state, [:users_counts, content_id])

    {:reply, counts, state}
  end

  def handle_cast({:set_user_counts, content_id, counts}, state) do
    state = put_in(state, [:users_counts, content_id], counts)

    {:noreply, state}
  end
end
