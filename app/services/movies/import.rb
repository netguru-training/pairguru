# frozen_string_literal: true
require 'rest-client'
require 'json'

module Movies
  class Import
    BASE_URL = 'https://pairguru-api.herokuapp.com/api/v1/movies/'

    def self.call(titles)
      new.call(titles)
    end

    def call(titles)
      titles.inject(Hash.new) do |movies_hash, title|
        movie = get_data(title)
        movie = Movies::AssignDefault.call(title) if movie.blank?

        movie_title = movie['data']['attributes']['title']
        movies_hash[movie_title] = movie['data']['attributes']
        movies_hash
      end
    end

    private

    def url(title)
      BASE_URL + title.gsub(' ', '%20')
    end

    def get_data(title)
      movie_url = url(title)
      response = RestClient.get movie_url
      JSON.parse(response)
    rescue RestClient::ExceptionWithResponse
      []
    end
  end
end
