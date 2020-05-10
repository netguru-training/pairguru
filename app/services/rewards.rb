class Rewards
  include Singleton
  attr_accessor :rewards
  
  def initialize
    update_rewards
  end
  
  def update_rewards
    summary = Comment
    .where(:created_at => (Date.today-7.days).beginning_of_day..Date.today.end_of_day)
    .select(:user_id, "count(id) as count")
    .group(:user_id)
    .order("count desc")
    .limit(10)
    @rewards = summary.map{|it| {email: User.find(it["user_id"]).email, count: it["count"]}}
  end
  
  def get_rewards
    @rewards
  end
end
