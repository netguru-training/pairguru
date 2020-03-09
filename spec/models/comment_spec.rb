require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'has a valid factory' do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it 'is invalid without description, user id or movie id' do
    comment = build(:comment, description: nil)
    expect(comment).to be_invalid

    comment = build(:comment, user: nil)
    expect(comment).to be_invalid

    comment = build(:comment, movie: nil)
    expect(comment).to be_invalid
  end

  context 'with description shorter than 2 characters' do
    it 'is invalid' do
      comment = build(:comment, description: 'A')
      expect(comment).to be_invalid
    end
  end

  context 'with description longer than 500 characters' do
    it 'is invalid' do
      description = 'a'
      description = description.ljust(540, 'a')
      comment = build(:comment, description: description)
      expect(comment).to be_invalid
    end
  end

  context 'when added by user for the second time to the same movie' do
    let!(:user)          { create(:user) }
    let!(:movie)         { create(:movie) }
    let!(:first_comment) { create(:comment, movie: movie, user: user) }

    it 'is invalid' do
      second_comment = build(:comment, movie: movie, user: user)
      expect(second_comment).to be_invalid
    end
  end
end
