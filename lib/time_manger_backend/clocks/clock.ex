defmodule TimeMangerBackend.Clocks.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :time, :naive_datetime
    field :status, :boolean, default: false
    #field :user_id, :id
    belongs_to :user, TimeMangerBackend.Users.User
    timestamps(type: :utc_datetime)
  end

  # must have user_id when create clock
  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])   # 加上 user_id
    |> validate_required([:time, :status, :user_id])
    |> assoc_constraint(:user)   # 确保 user_id 在 users 表里存在
  end
end
