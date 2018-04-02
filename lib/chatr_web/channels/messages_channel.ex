defmodule ChatrWeb.MessagesChannel do
  use ChatrWeb, :channel

  alias Chatr.Chat.{Room, Message}
  alias Chatr.Repo

  # called when JS client attempts to join MessagesChannel
  def join("messages:" <> room_id, _params, socket) do
    room_id = String.to_integer(room_id)
    room = Room
      |> Repo.get(room_id)
      |> Repo.preload(:messages)

    IO.inspect room

    {:ok, %{messages: room.messages}, assign(socket, :room, room)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    room = socket.assigns.room
    IO.puts "++++"
    IO.inspect room

    changeset = room
      |> Ecto.build_assoc(:messages)
      |> Message.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, message} ->
        broadcast!(socket, "messages:#{socket.assigns.room.id}:new",
          %{messages: render_messages([message])})
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  defp render_messages(messages) do
    Phoenix.View.render_many(messages, ChatrWeb.MessageView, "messages.json")
  end
end
