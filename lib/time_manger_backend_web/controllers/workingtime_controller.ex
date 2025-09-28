defmodule TimeMangerBackendWeb.WorkingtimeController do
  use TimeMangerBackendWeb, :controller

  alias TimeMangerBackend.Workingtimes
  alias TimeMangerBackend.Workingtimes.Workingtime

  action_fallback TimeMangerBackendWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Workingtimes.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{workingtime}")
      |> render(:show, workingtime: workingtime)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = Workingtimes.get_workingtime!(id)
    render(conn, :show, workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Workingtimes.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.update_workingtime(workingtime, workingtime_params) do
      render(conn, :show, workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Workingtimes.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Workingtimes.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end

  # def get_workingtimes_by_user(conn, %{"user_id" => user_id}) do
  #   workingtimes = Workingtimes.list_workingtimes_by_user(user_id)
  #   render(conn, :index, workingtimes: workingtimes)
  # end

  def get_by_user_and_range(conn, %{"user_id" => user_id} = params) do
  workingtimes =
    Workingtimes.list_by_user_and_range(user_id, params)

  render(conn, :index, workingtimes: workingtimes)
end

end
