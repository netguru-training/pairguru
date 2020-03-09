require 'rails_helper'

RSpec.describe Movies::Import do
  describe '#call' do
    let!(:movie) { create(:movie) }
    let!(:movie_data) do
      {
        'data' => {
          'id' => "#{movie.id}",
          'type' => 'movie',
          'attributes' => {
            'title' => "#{movie.title}",
            'plot' => 'Movie description',
            'rating' => 8.4,
            'poster' => "/#{movie.title}.jpg"
          }
        }
      }
    end

    let!(:default_data) do
      {
        'data' => {
          'id' => "#{movie.id}",
          'type' => 'movie',
          'attributes' => {
            'title' => "#{movie.title}",
            'plot' => 'Default description',
            'rating' => 4.6,
            'poster' => "/#{movie.title}.jpg"
          }
        }
      }
    end

    let!(:movies_hashes) do
      {
        "#{movie.title}" => {
          'title' => "#{movie.title}",
          'plot' => 'Movie description',
          'rating' => 8.4,
          'poster' => "/#{movie.title}.jpg"
        }
      }
    end

    let!(:default_movies_hashes) do
      {
        "#{movie.title}" => {
          'title' => "#{movie.title}",
          'plot' => 'Default description',
          'rating' => 4.6,
          'poster' => "/#{movie.title}.jpg"
        }
      }
    end

    context 'when movie is found by RestClient' do
      it 'returns array of movies hashes' do
        allow_any_instance_of(Movies::Import).to receive(:get_data).and_return(movie_data)

        expect(described_class.call([movie.title])).to eq movies_hashes
      end
    end

    context 'when movie is not found by RestClient' do
      it 'returns array of movies hashes with assigned default values' do
        allow_any_instance_of(Movies::Import).to receive(:get_data).and_return({})
        allow_any_instance_of(Movies::AssignDefault).to receive(:call).and_return(default_data)

        expect(described_class.call([movie.title])).to eq default_movies_hashes
      end
    end
  end
end
