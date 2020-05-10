class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  
  after_save :update_rewards
  after_destroy :update_rewards
  
  def update_rewards
    Rewards.instance().update_rewards
  end
end
