defmodule Chatr.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias Chatr.Repo

  alias Chatr.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def insert_or_update_user(changeset) do
    case Repo.get_by(User, name: changeset.changes.name) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
