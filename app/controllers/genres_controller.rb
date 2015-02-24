class GenresController < ApplicationController
  expose_decorated(:genres)
  expose_decorated(:genre)
end
