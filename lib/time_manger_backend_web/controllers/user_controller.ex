defmodule TimeMangerBackendWeb.UserController do
  use TimeMangerBackendWeb, :controller

  alias TimeMangerBackend.Users
  alias TimeMangerBackend.Users.User

  action_fallback TimeMangerBackendWeb.FallbackController

  # def index(conn, _params) do
  #   users = Users.list_users()
  #   render(conn, :index, users: users)
  # end

  # def index(conn, params) do
  #   users =
  #     cond do
  #       Map.has_key?(params, "username") and Map.has_key?(params, "email") ->
  #         Users.get_users_by_username_and_email(params["username"], params["email"])

  #       Map.has_key?(params, "username") ->
  #         Users.get_users_by_username(params["username"])

  #       Map.has_key?(params, "email") ->
  #         Users.get_users_by_email(params["email"])

  #       true ->
  #         Users.list_users()
  #     end

  #   render(conn, :index, users: users)
  # end

  def index(conn, params) do
    users = Users.search_users(params)
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

end
