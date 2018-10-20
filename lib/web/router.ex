defmodule Web.Router do
  use Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Web.Plugs.FetchUser
  end

  pipeline :admin do
    plug Web.Plugs.EnsureUser
  end

  scope "/", Web do
    pipe_through([:browser])

    get "/", PageController, :index

    resources("/sign-in", SessionController, only: [:new, :create, :delete], singleton: true)
  end

  scope "/", Web do
    pipe_through([:browser, :admin])

    resources("/channels", ChannelController, only: [:index, :show])
  end
end
