defmodule TimeMangerBackend.Workingtimes do
  @moduledoc """
  The Workingtimes context.
  """

  import Ecto.Query, warn: false
  alias TimeMangerBackend.Repo

  alias TimeMangerBackend.Workingtimes.Workingtime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime!(id), do: Repo.get!(Workingtime, id)

  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(attrs) do
    %Workingtime{}
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{data: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime, attrs \\ %{}) do
    Workingtime.changeset(workingtime, attrs)
  end

  def list_workingtimes_by_user(user_id) do
    query = from w in Workingtime, where: w.user_id == ^user_id
    Repo.all(query)
  end

  def list_by_user_and_range(user_id, params) do
    base_query =
      from(w in Workingtime, where: w.user_id == ^user_id)

    query =
      case {Map.get(params, "start"), Map.get(params, "end")} do
        {nil, nil} ->
          base_query

        {start_str, nil} ->
          {:ok, start_time} = NaiveDateTime.from_iso8601(normalize_datetime(start_str))
          from w in base_query, where: w.start >= ^start_time

        {nil, end_str} ->
          {:ok, end_time} = NaiveDateTime.from_iso8601(normalize_datetime(end_str))
          from w in base_query, where: w.end <= ^end_time

        {start_str, end_str} ->
          {:ok, start_time} = NaiveDateTime.from_iso8601(normalize_datetime(start_str))
          {:ok, end_time}   = NaiveDateTime.from_iso8601(normalize_datetime(end_str))
          from w in base_query,
            where: w.start >= ^start_time and w.end <= ^end_time
      end

    Repo.all(query)
  end

  # 支持 "YYYY-MM-DD HH:MM:SS" 和 "YYYY-MM-DDTHH:MM:SS"
  defp normalize_datetime(str) do
    if String.contains?(str, "T"), do: str, else: String.replace(str, " ", "T")
  end

  def get_user_work_times(user_id) do
    Repo.all(
      from wt in WorkingTime,
        where: wt.user_id == ^user_id,
        order_by: [desc: wt.start]
    )
  end

end
