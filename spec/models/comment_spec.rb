require "rails_helper"

describe Comment do
  let(:comment) { build(:comment) }
  
  it "triggers update_rewards on save" do
    expect(comment).to receive(:update_rewards) 
    comment.save
  end
  
  it "triggers update_rewards on destroy" do
    expect(comment).to receive(:update_rewards) 
    comment.destroy
  end  
end
