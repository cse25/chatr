defmodule Chatr.Repo.Migrations.ChangeNameToAuthorInMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :author, :string
      remove :name
    end
  end
end
