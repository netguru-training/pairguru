require 'rails_helper'

RSpec.describe Users::Queries::TopCommenters do
  describe '#call' do
    let!(:users)           { create_list(:user, 11) }
    let!(:movies)          { create_list(:movie, 11) }
    let!(:comments_count)  { [11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1] }
    subject { described_class.call }

    context 'when comments were added more than 7 days ago' do
      it 'returns no users' do
        create_comments(true)

        expect(subject).to eq []
      end
    end

    context 'when comments were added less than 7 days ago' do
      it 'returns up to ten users with most comments' do
        create_comments
        selected_users_ids = User.order('id ASC').limit(10).pluck(:id)

        expect(subject.map(&:id)).to eq selected_users_ids
      end
    end
  end

  def create_comments(expired = false)
    movies_ids = movies.pluck(:id)

    users.each_with_index do |user, i|
      selected_movies_ids = movies_ids[0..(comments_count[i] - 1)]

      selected_movies_ids.each do |movie_id|
        Comment.create!(
          description: Faker::Lorem.paragraph(5),
          movie_id: movie_id,
          user_id: user.id,
          created_at: expired ? 8.days.ago : DateTime.now
        )
      end
    end
  end
end
