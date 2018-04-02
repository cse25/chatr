defmodule ChatrWeb.MessageView do
  use ChatrWeb, :view

  def render("messages.json", %{message: message}) do
    %{
      id: message.id,
      content: message.content
    }
  end
end
