defmodule Chatr.Chat do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias Chatr.Repo

  alias Chatr.Chat.Room

  def list_rooms do
    Repo.all(Room)
  end

  def get_room!(id), do: Repo.get!(Room, id)

  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end
end
