class FetchWeather
  include Interactor

  def call
    context.fail!(message: "No lat/lon found") if context.lat.nil? || context.lon.nil?
    context.fail!(message: "No postal code found") if context.postal_code.nil?

    cached = true
    result = Rails.cache.fetch(context.postal_code, expires_in: 30.minutes) do
      cached = false
      OpenWeatherClient.current_weather(lat: context.lat, lon: context.lon, units: "imperial")
    end

    context.fail!(message: "No weather forecast found") unless result&.main

    context.forecast = WeatherForecast.new(
      current_temp: result.main.temp,
      feels_like: result.main.feels_like,
      cached: cached
    )
  rescue Faraday::ClientError
    context.fail!(message: "Unable to retrieve forecast")
  end
end
