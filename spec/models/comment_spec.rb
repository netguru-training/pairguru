require "rails_helper"

describe Comment do
  let(:comment) { build(:comment) }
  
  it "triggers after_save on save" do
    expect(comment).to receive(:after_save) 
    comment.save
  end
end
