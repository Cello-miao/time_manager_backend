defmodule TimeMangerBackend.WorkingtimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeMangerBackend.Workingtimes` context.
  """

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2025-09-25 08:13:00],
        start: ~N[2025-09-25 08:13:00]
      })
      |> TimeMangerBackend.Workingtimes.create_workingtime()

    workingtime
  end
end
