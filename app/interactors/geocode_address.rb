class GeocodeAddress
  include Interactor

  def call
    result = Geocoder.search(context.address)

    context.fail!(message: "No geocode info found") if result.empty?
    context.geocoded_address = result.first
  rescue Geocoder::Error
    context.fail!(message: "Unable to geocode address")
  end

end
