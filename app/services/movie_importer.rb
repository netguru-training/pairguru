require "net/http"

class MovieImporter

  attr_reader :movie, :url

  def initialize(movie)
    @movie = movie
  end

  def call
    response = RestClient.get(url)
    return JSON.parse(response.body)["data"]["attributes"] if response.code == 200
    []
  rescue
    return []
  end

  private

  def url
    @url = "https://pairguru-api.herokuapp.com/api/v1/movies/#{movie_title}"
  end

  def movie_title
    URI.encode(movie.title)
  end

end
