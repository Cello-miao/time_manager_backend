defmodule TimeMangerBackend.ClocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeMangerBackend.Clocks` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2025-09-25 08:12:00]
      })
      |> TimeMangerBackend.Clocks.create_clock()

    clock
  end
end
