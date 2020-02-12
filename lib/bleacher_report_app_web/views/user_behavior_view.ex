defmodule BleacherReportAppWeb.UserBehaviorView do
  use BleacherReportAppWeb, :view

  def render("handle_fire_action.json", %{user_content_behavior: user_content_behavior}) do
    %{
      data:
        render_one(
          user_content_behavior,
          BleacherReportAppWeb.UserBehaviorView,
          "user_behavior.json"
        )
    }
  end

  def render("user_behavior.json", %{user_behavior: user_behavior}) do
    %{
      type: user_behavior.type,
      action: user_behavior.action,
      content_id: user_behavior.content_id,
      user_id: user_behavior.user_id,
      reaction_type: user_behavior.reaction_type
    }
  end

  def render("reaction_counts.json", %{counts: counts, content_id: cont_id}) do
    %{
      content_id: cont_id,
      reaction_count: "fire: " <> to_string(counts)
    }
  end
end
