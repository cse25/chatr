defmodule Dixit.Accounts.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :author, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:author])
    |> validate_required([:author])
    |> unique_constraint(:author)
  end
end
