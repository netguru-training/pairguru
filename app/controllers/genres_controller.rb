class GenresController < ApplicationController
  expose_decorated(:genres) { Genres.all }
  expose_decorated(:genre)
end
