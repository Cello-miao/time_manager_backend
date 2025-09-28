defmodule TimeMangerBackendWeb.WorkingtimeJSON do
  alias TimeMangerBackend.Workingtimes.Workingtime

  @doc """
  Renders a list of workingtimes.
  """
  def index(%{workingtimes: workingtimes}) do
    %{data: for(workingtime <- workingtimes, do: data(workingtime))}
  end

  @doc """
  Renders a single workingtime.
  """
  def show(%{workingtime: workingtime}) do
    %{data: data(workingtime)}
  end

  defp data(%Workingtime{} = workingtime) do
    %{
      id: workingtime.id,
      start: NaiveDateTime.to_string(workingtime.start),
      end: NaiveDateTime.to_string(workingtime.end),
      user_id: workingtime.user_id   # 加上这一行
    }
  end
end
