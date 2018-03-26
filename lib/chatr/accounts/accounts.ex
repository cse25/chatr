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

  # def insert_or_update_user(%{"name" => name} = attrs \\ %{}) do
  #   case Repo.get_by(User, name: name) do
  #     nil ->
  #       %User{}
  #       |> User.changeset(attrs)
  #       |> Repo.insert()
  #     user ->
  #       {:ok, user}
  #   end
  # end

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
