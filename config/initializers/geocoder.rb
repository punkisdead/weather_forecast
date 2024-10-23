Geocoder.configure(
  lookup: :geoapify,
  api_key: ENV["GEOCODING_API_KEY"],
  timeout: 5,
  units: :mi,
)
