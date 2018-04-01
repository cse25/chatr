defmodule ChatrWeb.MessagesChannel do
  use ChatrWeb, :channel

  alias Chatr.Chat.Room
  alias Chatr.Repo

  # called when JS client attemps to join MessagesChannel
  def join("messages:" <> room_id, _params, socket) do
    room_id = String.to_integer(room_id)
    room = Repo.get(Room, room_id)
    #name => "messages:18"
    {:ok, %{}, socket}
  end

  def handle_in(name, message, socket) do
    {:reply, :ok, socket}
  end
end
