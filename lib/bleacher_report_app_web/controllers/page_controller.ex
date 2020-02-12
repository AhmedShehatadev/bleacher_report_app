defmodule BleacherReportAppWeb.PageController do
  use BleacherReportAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
