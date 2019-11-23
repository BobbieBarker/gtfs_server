defmodule GtfsServer.Support.Fixtures.Stop do
  alias GtfsServer.Agencies


  def setup_stop(_context) do
    {:ok, stop} = Agencies.create_stop(%{
      stop_id: 3,
      stop_code: 3,
      stop_name: "A Ave & Second St",
      stop_desc: "Eastbound stop in Lake Oswego (Stop ID 3)",
      stop_url: "http://trimet.org/",
      stop_timezone: "America/Los_Angeles",
      location: "",
      stop_url: "http://trimet.org/#tracker/stop/3",
      parent_Station: nil
    })

    {:ok, %{stop: stop}}
  end
end
