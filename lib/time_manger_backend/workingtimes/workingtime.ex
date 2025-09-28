defmodule TimeMangerBackend.Workingtimes.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :start, :naive_datetime
    field :end, :naive_datetime
    #field :user_id, :id
    belongs_to :user, TimeMangerBackend.Users.User
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start, :end, :user_id])   # 加上 user_id
    |> validate_required([:start, :end, :user_id])
    |> assoc_constraint(:user)   # 确保 user_id 在 users 表里
  end

  # defp validate_start_end(changeset) do
  #   start_time = get_field(changeset, :start)
  #   end_time = get_field(changeset, :end)

  #   if start_time && end_time && NaiveDateTime.compare(start_time, end_time) != :lt do
  #     add_error(changeset, :end, "must be after start time")
  #   else
  #     changeset
  #   end
  # end
end
