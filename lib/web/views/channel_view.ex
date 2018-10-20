defmodule Web.ChannelView do
  use Web, :view

  @timezone "America/New_York"

  def display_time(message) do
    time_zone = Timex.Timezone.get(@timezone, Timex.now())

    message.inserted_at
    |> Timex.Timezone.convert(time_zone)
    |> Timex.format!("%Y-%m-%d %r %z", :strftime)
  end
end
