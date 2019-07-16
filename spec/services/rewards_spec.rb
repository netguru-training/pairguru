require "rails_helper"

describe "Rewards" do
  let(:comment) {build(:comment)}
  
  before do
    Singleton.__init__(Rewards)
  end
  
  it "rewards list should be not empty" do
    comment.created_at = Time.now
    comment.save
    expect(Rewards.instance.rewards).to_not be_empty
  end

  it "rewards list should be empty" do
    comment.created_at = Time.now - 10.days
    comment.save
    expect(Rewards.instance.rewards).to be_empty
  end
end
