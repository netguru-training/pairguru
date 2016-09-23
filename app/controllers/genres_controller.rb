class GenresController < ApplicationController
  expose_decorated(:genres) { Genre.all }
  expose_decorated(:genre)
end
