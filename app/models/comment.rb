# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  movie_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :content, presence: true
  validates :user, uniqueness: { scope: :movie }

  scope :ordered, -> { order(created_at: :desc) }
end
