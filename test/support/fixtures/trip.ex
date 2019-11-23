defmodule GtfsServer.Support.Fixtures.Trip do
  alias GtfsServer.Agencies

  def setup_trip _context do
    {:ok, %{routes: [%{trips: [trip]}]}} = Agencies.create_agency(%{
      agency_id: "TRIMET",
      agency_name: "TriMet",
      agency_url: "http://trimet.org/",
      agency_timezone: "America/Los_Angeles",
      routes: [%{
        route_id: 10,
        trips: [%{
          route_id: 10,
          trip_id: 3
        }]
      }]
    })

    {:ok, %{trip: trip}}
  end
end
