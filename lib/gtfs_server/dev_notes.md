

mix test test/my_project_test.exs:10

# todo refactor gtfs rt polling so that it can be configured and ran dynamically
# after a user has completed the setup process.


# implement file upload capability
  # read file data i.e rows from the csv files
  # write file data to the data base.

# routes -> trips -> stops
# trips identify the route they belong too
# many to one relationship between trips and routes

# write order:
# agencies.txt -> routes -> trips -> stops -> stop_times