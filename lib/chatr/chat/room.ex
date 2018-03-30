defmodule Chatr.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :title, :string
    belongs_to :user, Chatr.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
