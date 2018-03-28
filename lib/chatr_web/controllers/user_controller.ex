defmodule ChatrWeb.UserController do
  use ChatrWeb, :controller

  alias Chatr.Accounts
  alias Chatr.Accounts.User

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user} = params) do
    changeset = User.changeset(%User{}, user)

    signin(conn, changeset)
  end

  defp signin(conn, changeset) do
    case Accounts.insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome")
        |> put_session(:user_id, user.id)
        |> redirect(to: room_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error Signing In")
        |> redirect(to: user_path(conn, :new))
    end
  end
end
