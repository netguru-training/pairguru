require "rails_helper"

describe "Rewards requests", type: :request do
  describe "users rewards" do
    it "displays table" do
      visit "/rewards"
      expect(page).to have_css(".table-striped")
    end
  end
end

