defmodule Web.ChannelController do
  use Web, :controller

  alias Backbone.Channels
  alias Raisin.Messages

  def index(conn, _params) do
    conn
    |> assign(:channels, Channels.all(include_hidden: true))
    |> render("index.html")
  end

  def show(conn, %{"id" => name}) do
    with {:ok, channel} <- Channels.get(name) do
      conn
      |> assign(:channel, channel)
      |> assign(:messages, Messages.for_channel(channel))
      |> render("show.html")
    end
  end
end
