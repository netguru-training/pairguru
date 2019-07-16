class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  
  after_save :after_save
  
  def after_save
    Rewards.instance().update_rewards
  end
end
