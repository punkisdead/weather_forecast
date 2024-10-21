class SearchController < ApplicationController
  def index
    @search_param = params[:query]
  end

end
