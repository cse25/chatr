defmodule Chatr.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:content, :id, :user]}

  schema "messages" do
    field :content, :string
    belongs_to :user, Chatr.Accounts.User
    belongs_to :room, Chatr.Chat.Room

    timestamps()
  end

  @doc false
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
