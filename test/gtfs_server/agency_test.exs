defmodule GtfsServer.AgenciesTest do
  use GtfsServer.DataCase, async: true
  alias GtfsServer.Agencies
  alias GtfsServer.Repo

  import GtfsServer.Support.Fixtures.Agency, only: [setup_agency: 1, setup_agencies: 1]
  import GtfsServer.Support.Fixtures.Stop, only: [setup_stop: 1]
  import GtfsServer.Support.Fixtures.Route, only: [setup_route: 1]
  import GtfsServer.Support.Fixtures.Trip, only: [setup_trip: 1]

  describe "&list_agencies/1" do
    setup [:setup_agencies]
    test "lists all agencies" do

      assert {:ok, agencies} = Agencies.list_agencies()

      assert length(agencies) === 2
    end
  end

  describe "&find_agency/1" do
    setup [:setup_agency]

    test "finds the specified agency by id", %{agency: %{id: id}} do

      assert {:ok, %{id: found_id}} = Agencies.find_agency(%{id: id})
      assert id === found_id
    end
  end

  describe "&update_agency/2" do
    setup [:setup_agency]

    test "updated the specified agency by id", %{agency: %{id: id}} do
      assert {:ok, updated_agency} = Agencies.update_agency(id, %{agency_name: "updated name", agency_email: "updated@email.com"})
      assert updated_agency.agency_name === "updated name"
      assert updated_agency.agency_email === "updated@email.com"
    end
  end

  describe "&create_agency/1" do
    test "creates a record in the db" do
      assert {:ok, _agency} = Agencies.create_agency(%{
        agency_id: "TRIMET",
        agency_name: "TriMet",
        agency_url: "http://trimet.org/",
        agency_timezone: "America/Los_Angeles",
        gtfs_rt_configs: %{
          base_url: "some_url",
          vehicle_position_feed_path: "/vehicles",
          alert_feed_path: "/alerts",
          trip_update_feed_path: "/trips",
          route_config_path: "/routes"
        }
      })

      assert agency = Agencies.Agency
      |> Repo.get_by(agency_id: "TRIMET")
      |> Repo.preload(:gtfs_rt_configs)

      assert agency.agency_name === "TriMet"
      assert agency.agency_timezone === "America/Los_Angeles"
      assert agency.gtfs_rt_configs.base_url === "some_url"
    end
  end

  describe "&update_stop/2" do
    setup [:setup_stop]

    test "updates a stop", %{stop: %{id: id}} do
      assert {:ok, updated_agency} = Agencies.update_stop(id, %{stop_desc: "a great desc"})

      assert updated_stop = Agencies.Stop
      |> Repo.get_by(id: id)

      assert updated_stop.stop_desc === "a great desc"
    end
  end

  describe "&create_stop/1" do
    test "creates a stop in the database" do
      assert {:ok, stop} = Agencies.create_stop(%{
        stop_id: 12,
        stop_name: "TriMet",
        stop_url: "http://trimet.org/",
        stop_timezone: "America/Los_Angeles",
        stop_lat: 45.419388,
        stop_lon: -122.665197
      })

      assert stop = Repo.get_by(Agencies.Stop, stop_id: 12)
    end
  end


  describe "&update_route/2" do
    setup [:setup_route]

    test "updates a route for the target agency", %{route: %{id: id}} do

      assert {:ok, updated_route} = Agencies.update_route(id, %{route_desc: "Updated description"})

        assert updated_route = Agencies.Route
        |> Repo.get_by(id: id)

        assert updated_route.route_desc === "Updated description"
    end
  end

  describe "&create_route/1" do
    setup [:setup_agency]

    test "creates a route in the database", %{agency: %{id: id}} do
      assert {:ok, %{id: route_id}} = Agencies.create_route(%{
        route_id: 3,
        agency_id: id
      })

      assert trip = Repo.get_by(Agencies.Route, id: route_id)
    end
  end

  describe "&create_trip/2" do
    setup [:setup_route]

    test "creates a trip in the database", %{route: route} do
      assert {:ok, %{id: trip_id}} = Agencies.create_trip(%{
        route_id: 12,
        trip_id: 3,
        trips_route_id: route.id
      })
      assert trip = Repo.get_by(Agencies.Trip, id: trip_id)
    end
  end

  describe "&create_vehicle/1" do
    test "creates a vehicle in the database" do
      assert {:ok, %{id: vehicle_id}} = Agencies.create_vehicle(%{
        vehicle_id: 123
      })

      assert vehicle = Repo.get_by(Agencies.Vehicle, id: vehicle_id)
    end
  end

  describe "&create_stop_times/1" do
    setup [:setup_trip, :setup_stop]

    test "creates a stop_time in the database", %{trip: %{id: trip_id}, stop: %{id: stop_id}} do
      assert {:ok, %{id: stop_time_id}} = Agencies.create_stop_time(%{
        trip_id: 2,
        stop_id: 3,
        stop_sequence: 1,
        trip_stop_id: trip_id,
        stop_trip_id: stop_id
      })

      assert stop_time = Repo.get_by(Agencies.StopTime, id: stop_time_id)
    end
  end
end
