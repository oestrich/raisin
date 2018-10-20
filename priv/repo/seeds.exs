alias Raisin.Accounts

{:ok, _user} = Accounts.register(%{
  email: "admin@example.com",
  password: "password",
  password_hash: "password",
})
