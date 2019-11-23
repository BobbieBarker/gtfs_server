defmodule GtfsServer.Support.Fixtures.Route do
  alias GtfsServer.Agencies

  def setup_route _context do
    {:ok, %{routes: [route]}} = Agencies.create_agency(%{
      agency_id: "TRIMET",
      agency_name: "TriMet",
      agency_url: "http://trimet.org/",
      agency_timezone: "America/Los_Angeles",
      routes: [%{
        route_id: 10
      }]
    })

    {:ok, %{route: route}}
  end
end
