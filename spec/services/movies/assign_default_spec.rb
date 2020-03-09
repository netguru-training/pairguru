require 'rails_helper'

RSpec.describe Movies::AssignDefault do
  describe '#call' do
    let!(:movie)       { create(:movie) }
    let!(:description) { 'Short description' }
    let!(:data_hash) do
      {'data' => {
        'attributes'=> {
          'title' => movie.title,
          'plot' => description,
          'rating' => 4.5,
          'poster' => '/deadpool.jpg'
          }
        }
      }
    end

    it 'returns array of movies hashes' do
      allow_any_instance_of(Movies::AssignDefault).to receive(:generate_random_rating).and_return(4.5)
      allow(Faker::Lorem).to receive(:paragraph).with(5).and_return('Short description')

      expect(described_class.call(movie.title)).to eq data_hash
    end
  end
end
