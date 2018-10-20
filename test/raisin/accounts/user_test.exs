defmodule Raisin.Accounts.UserTest do
  use Raisin.DataCase

  alias Raisin.Accounts.User

  setup do
    %{user: %User{}}
  end

  describe "validations" do
    test "trims email", %{user: user} do
      changeset = User.changeset(user, %{
        email: "user@example.com ",
      })

      assert changeset.changes[:email] == "user@example.com"
    end
  end
end
