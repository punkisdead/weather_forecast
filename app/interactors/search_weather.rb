class SearchWeather
  include Interactor::Organizer

  organize GeocodeAddress, ParseGeocodeInfo, FetchWeather
end
