defmodule GtfsServer.Support.Fixtures.Agency do
  alias GtfsServer.Agencies

  def setup_agency _context do
    {:ok, agency} = Agencies.create_agency(%{
      agency_id: "TRIMET",
      agency_name: "TriMet",
      agency_url: "http://trimet.org/",
      agency_timezone: "America/Los_Angeles",
      agency_lang: "en",
      angency_phone: "503-238-RIDE",
      agency_fare_url: "http://trimet.org/fares/,",
      agency_email: "customerservice@trimet.org"
    })

    {:ok, %{agency: agency}}
  end

  def setup_agencies _context do
    {:ok, agency1} = Agencies.create_agency(%{
      agency_id: "TRIMET",
      agency_name: "TriMet",
      agency_url: "http://trimet.org/",
      agency_timezone: "America/Los_Angeles",
      agency_lang: "en",
      angency_phone: "503-238-RIDE",
      agency_fare_url: "http://trimet.org/fares/,",
      agency_email: "customerservice@trimet.org"
    })

    {:ok, agency2} = Agencies.create_agency(%{
      agency_id: "MTA NYCT",
      agency_name: "MTA New York City Transit",
      agency_url: "http://www.mta.info",
      agency_timezone: "America/New_York",
      agency_lang: "en",
      angency_phone: "718-330-1234"
    })

    {:ok, %{agency1: agency1, agency2: agency2}}
  end
end
