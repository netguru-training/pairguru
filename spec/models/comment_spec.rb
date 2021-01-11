require "rails_helper"

describe Comment do
  let(:comment) { create(:comment) }
  let(:user) { comment.user }
  let(:movie) { comment.movie }
  let(:second_movie) { create(:movie) }

  it "should not create comment without content" do
    is_expected.not_to allow_value("").for(:content)
  end

  it "should not create second comment to movie by the same user" do
    new_comment = Comment.new(content: "lorem", user: user, movie: movie)
    result = new_comment.save
    expect(result).to be_falsey
    expect(new_comment.errors.messages).to eq(:user=>["has already been taken"])
  end

  it "should allow to create comment to another movie by the same user" do
    new_comment = Comment.new(content: "lorem", user: user, movie: second_movie)
    result = new_comment.save
    expect(result).to be_truthy
    expect(new_comment.errors.messages).to be_empty
  end

end