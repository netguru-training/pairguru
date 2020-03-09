require 'rails_helper'

RSpec.describe Movies::DetailedSerializer do
  let(:movie_1)       { create(:movie) }
  let(:serializer)    { described_class.new(movie_1) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  subject { JSON.parse(serialization.to_json) }

  let(:movie_hash) do
    {
      'id' => movie_1.id,
      'title' => movie_1.title,
      'genre' => {
        'id' => movie_1.genre.id,
        'name' => movie_1.genre.name,
        'number_of_movies' => movie_1.genre.movies.count
      }
    }
  end

  context 'for single movie' do
    it 'returns movie hash with genre' do
      expect(subject).to eq(movie_hash)
    end
  end
end
