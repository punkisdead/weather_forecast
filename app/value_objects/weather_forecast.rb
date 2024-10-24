class WeatherForecast
  attr_reader :current_temp, :feels_like, :cached

  def initialize(current_temp:, feels_like:, cached:)
    @current_temp = current_temp
    @feels_like = feels_like
    @cached = cached
  end

  def ==(other)
    self.class == other.class &&
    self.current_temp == other.current_temp &&
    self.feels_like == other.feels_like &&
    self.cached == other.cached
  end
end
