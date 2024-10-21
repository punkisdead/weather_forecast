class FetchWeather
  include Interactor

  def call
    context.cached = true
    result = Rails.cache.fetch(context.postcode, expires_in: 2.minutes) do
      context.cached = false
      OpenWeatherClient.current_weather(lat: context.lat, lon: context.lon, units: "imperial")
    end

    context.forecast = result.main
  end
end
