class SearchController < ApplicationController
  def index
    @search_param = params[:query]
    @result = SearchWeather.call(address: @search_param) if @search_param
  end
end
