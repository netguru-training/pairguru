class RewardsController < ApplicationController
  def index
    @rewards = Rewards.instance().get_rewards
  end
end
