require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
  let(:movie_1) { create(:movie) }
  let(:movie_2) { create(:movie) }
  # let!(:movies_hash) do
  #   create(:movie)
  # end

  describe 'GET index' do
    context 'when include_genre params is present' do
      it 'renders array of movies hashes with genres as json' do
        response_array = [
          {
            id: movie_1.id,
            title: movie_1.title,
            genre: {
              id: movie_1.genre.id,
              name: movie_1.genre.name,
              number_of_movies: movie_1.genre.movies.count
            }
          },
          {
            id: movie_2.id,
            title: movie_2.title,
            genre: {
              id: movie_2.genre.id,
              name: movie_2.genre.name,
              number_of_movies: movie_2.genre.movies.count
            }
          }
        ].to_json

        get :index, params: { include_genre: true }
        expect(response.body).to eq response_array
      end
    end

    context 'when include_genre params is absent' do
      it 'renders array of movies hashes as json' do
        response_array = [
          {
            id: movie_1.id,
            title: movie_1.title
          },
          {
            id: movie_2.id,
            title: movie_2.title
          }
        ].to_json

        get :index
        expect(response.body).to eq response_array
      end
    end
  end

  describe 'GET show' do
    context 'when movie is present' do
      context 'when include_genre params is present' do
        it 'renders movie hash with genre as json' do
          response_hash = {
              id: movie_1.id,
              title: movie_1.title,
              genre: {
                id: movie_1.genre.id,
                name: movie_1.genre.name,
                number_of_movies: movie_1.genre.movies.count
              }
            }.to_json

          get :show, params: { id: movie_1.id, include_genre: true }
          expect(response.body).to eq response_hash
        end
      end

      context 'when include_genre params is absent' do
        it 'renders movie hash as json' do
          response_hash = { id: movie_1.id, title: movie_1.title,}.to_json

          get :show, params: { id: movie_1.id }
          expect(response.body).to eq response_hash
        end
      end
    end

    context 'when movie is absent' do
      it 'renders record not found' do
        error_message = { error: I18n.t('movie.not_found') }.to_json

        get :show, params: { id: movie_2.id + 1 }
        expect(response.body).to eq error_message
      end
    end
  end
end
