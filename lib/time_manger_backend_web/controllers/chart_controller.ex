defmodule TimeMangerBackendWeb.ChartController do
  use TimeMangerBackendWeb, :controller

  alias TimeMangerBackend.Clocks.Clock.Clocks
  alias TimeMangerBackend.Workingtimes.Workingtime
  alias TimeMangerBackend.Repo
  import Ecto.Query

  def work_hours(conn, %{"user_id" => user_id}) do
    user_id = String.to_integer(user_id)

    # 查询该用户的 Workingtime
    working_times =
      Repo.all(
        from wt in Workingtime,
          where: wt.user_id == ^user_id,
          order_by: [asc: wt.start]
      )

    # 按日期汇总每天工时（小时）
    data =
      working_times
      |> Enum.group_by(fn wt -> NaiveDateTime.to_date(wt.start) end)
      |> Enum.map(fn {date, times} ->
        hours =
          times
          |> Enum.map(fn t ->
            t_end = t.end || t.start
            diff = NaiveDateTime.diff(t_end, t.start, :minute)
            diff / 60.0
          end)
          |> Enum.sum()

        %{date: Date.to_string(date), hours: hours}
      end)
      |> Enum.sort_by(& &1.date)

    json(conn, %{data: data})
  end
end
