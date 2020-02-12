defmodule BleacherReportApp.Repo do
  use Ecto.Repo,
    otp_app: :bleacher_report_app,
    adapter: Ecto.Adapters.Postgres
end
