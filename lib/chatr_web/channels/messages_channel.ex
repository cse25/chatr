defmodule ChatrWeb.MessagesChannel do
  use ChatrWeb, :channel

  alias Chatr.Chat.{Room, Message}
  alias Chatr.Repo

  # called when JS client attempts to join MessagesChannel
  def join("messages:" <> room_id, _params, socket) do
    room_id = String.to_integer(room_id)

    room =
      Room
      |> Repo.get(room_id)
      |> Repo.preload(messages: :user)

    # messages = render_messages(room.messages)

    {:ok, %{messages: room.messages}, assign(socket, :room, room)}
  end

  def handle_in(_name, %{"content" => content}, socket) do
    room = socket.assigns.room
    user_id = socket.assigns.user_id

    changeset = room
      |> Ecto.build_assoc(:messages, user_id: user_id)
      |> Message.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, message} ->
        broadcast!(socket, "messages:#{socket.assigns.room.id}:new",
          # %{messages: render_messages([message])})
          %{message: message}
        )
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  # defp render_messages(messages) do
  #   Phoenix.View.render_many(messages, ChatrWeb.MessageView, "messages.json")
  # end
end
