require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'has a valid factory' do
    movie = build(:movie)
    expect(movie).to be_valid
  end

  context 'destroys all comments assigned to movie' do
    let!(:movie)    { create(:movie) }
    let!(:comments) { create_list(:comment, 2, movie: movie) }

    it 'when movie is deleted' do
      expect { movie.destroy }.to change { Movie.count }.by(-1).and change { Comment.count }.by(-2)
    end
  end
end
