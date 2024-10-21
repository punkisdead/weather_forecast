class GeocodeAddress
  include Interactor

  def call
    result = Geocoder.search(context.address)

    context.lat = result.first.latitude
    context.lon = result.first.longitude
    context.postcode = result.first.postal_code
  end

end
