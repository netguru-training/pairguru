class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :description, length: { minimum: 2, maximum: 500 }
  validates :description, :user_id, :movie_id, presence: true
  validates :movie_id, uniqueness: { scope: :user_id }
end
