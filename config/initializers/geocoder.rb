Geocoder.configure(
  # street address geocoding service (default :nominatim)
  lookup: :geoapify,

  # to use an API key:
  api_key: "2a939d7f77da46118e411a62c3a47912",

  # geocoding service request timeout, in seconds (default 3):
  timeout: 5,

  # set default units to kilometers:
  units: :km,

  # caching (see Caching section below for details):
  # cache: Redis.new,
  # cache_options: {
  #   expiration: 1.day, # Defaults to `nil`
  #   prefix: "another_key:" # Defaults to `geocoder:`
  # }
)
