class Api::MoviesController < ApplicationController
  def index
    @with_details = params[:details] and params[:details] == 'true';
    @movies = Movie.all
  end
end
