defmodule TimeMangerBackend.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeMangerBackend.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> TimeMangerBackend.Users.create_user()

    user
  end
end
