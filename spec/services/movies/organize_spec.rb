require 'rails_helper'

RSpec.describe Movies::Organize do
  describe '#call' do
    let!(:movie_1)       { create(:movie, ) }
    let!(:movie_2)       { create(:movie, ) }
    let!(:movies_list)   { [movie_1, movie_2] }
    let!(:image_url)     { 'https://pairguru-api.herokuapp.com/' }
    let!(:description_1) { 'Imported data about movie 1' }
    let!(:description_2) { 'Imported data about movie 2' }
    let!(:movies_struct) do
      Movies::Organize::Movie = Struct.new(
        :id,
        :title,
        :released_at,
        :genre_id,
        :genre_name,
        :created_at,
        :updated_at,
        :description,
        :avatar,
        :rating
      )

      movie_1_struct = create_movie_struct(Movies::Organize::Movie, movie_1, description_1, 8.4)
      movie_2_struct = create_movie_struct(Movies::Organize::Movie, movie_2, description_2, 10.0)

      [movie_1_struct, movie_2_struct]
    end

    let!(:imported_movies_data) do
      {
        "#{movie_1.title}" => {
          'title' => "#{movie_1.title}",
          'plot' =>
            'Imported data about movie 1',
          'rating' => 8.4,
          'poster' => "/#{movie_1.title}.jpg"
        },
        "#{movie_2.title}" => {
          'title' => "#{movie_2.title}",
          'plot' =>
            'Imported data about movie 2',
          'rating' => 10.0,
          'poster' => "/#{movie_2.title}.jpg"
        }
      }
    end

    it 'creates array of movies structs' do
      expect(described_class.call(movies_list, imported_movies_data)).to eq(movies_struct)
    end

    def create_movie_struct(struct, movie, description, rating)
      struct.new(
        movie.id,
        movie.title,
        movie.released_at,
        movie.genre_id,
        movie.genre.name,
        movie.created_at,
        movie.updated_at,
        description,
        image_url + "/#{movie.title}.jpg",
        rating
      )
    end
  end
end

# # frozen_string_literal: true

# module Movies
#   class Organize
#     IMAGE_URL = 'https://pairguru-api.herokuapp.com/'
#     Movie = Struct.new(
#       :id,
#       :title,
#       :released_at,
#       :genre_id,
#       :genre_name,
#       :created_at,
#       :updated_at,
#       :description,
#       :avatar,
#       :rating
#     )

#     def self.call(movies_list, imported_movies_data)
#       new.call(movies_list, imported_movies_data)
#     end

#     def call(movies_list, imported_movies_data)
#       movies_list.map do |movie|
#         merge_movie_with_imported_data(movie, imported_movies_data)
#       end
#     end

#     private

#     def merge_movie_with_imported_data(movie, imported_movies_data)
#       Movie.new(
#         movie&.id,
#         movie&.title,
#         movie&.released_at,
#         movie&.genre_id,
#         movie&.genre.name,
#         movie&.created_at,
#         movie&.updated_at,
#         imported_movies_data["#{movie.title}"]['plot'],
#         image_path(imported_movies_data["#{movie.title}"]['poster']),
#         imported_movies_data["#{movie.title}"]['rating']
#       )
#     end

#     def image_path(image)
#       IMAGE_URL + image
#     end
#   end
# end
