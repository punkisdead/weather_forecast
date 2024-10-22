class ParseGeocodeInfo
  include Interactor

  def call
    context.fail!(message: "No latitude found") unless context.geocoded_address.latitude
    context.fail!(message: "No longitude found") unless context.geocoded_address.longitude
    context.fail!(message: "No postal code found") unless context.geocoded_address.postal_code

    context.lat = context.geocoded_address.latitude
    context.lon = context.geocoded_address.longitude
    context.postal_code = context.geocoded_address.postal_code
  end
end
