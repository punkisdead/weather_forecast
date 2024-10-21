Rails.application.config.after_initialize do
  OpenWeatherClient = OpenWeather::Client.new(api_key: ENV["OPEN_WEATHER_API_KEY"])
end
