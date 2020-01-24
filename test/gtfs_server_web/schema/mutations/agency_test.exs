defmodule GtfsServerWeb.Schema.Mutations.AgencyTest do

  use GtfsServerWeb.ConnCase

  @query """
    mutation {uploadAgency(agencies: "file_data_attribute_arbitraty_name")}
  """

  test "upload file", %{conn: conn} do
    upload = %Plug.Upload{
      content_type: "text/csv",
      filename: "users.csv",
      path: Path.expand("../../../../users.csv", __DIR__)
    }

    assert resp =
      conn
      |> post("/graphql", %{"query" => @query, "file_data_attribute_arbitraty_name" => upload})

    assert "{\"data\":{\"uploadAgency\":\"success\"}}" = response(resp, 200)
  end
end
