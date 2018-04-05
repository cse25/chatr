defmodule Chatr.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:name]}

  schema "users" do
    field :name, :string
    has_many :rooms, Chatr.Chat.Room
    has_many :messages, Chatr.Chat.Message

    timestamps()
  end

  @doc false
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
