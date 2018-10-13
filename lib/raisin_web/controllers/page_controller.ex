defmodule RaisinWeb.PageController do
  use RaisinWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
