defmodule Dixit.Accounts.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
