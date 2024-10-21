class SearchWeather
  include Interactor::Organizer

  organize GeocodeAddress, FetchWeather
end
