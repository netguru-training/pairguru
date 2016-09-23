class MoviesController < ApplicationController
  expose_decorated(:movies) { Movie.all }
end
