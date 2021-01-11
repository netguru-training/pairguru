require "rails_helper"

describe "Movies requests", type: :request do
  let!(:movies) { create_list(:movie, 20) }

  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end

    it "displays table of all movies" do
      visit "/movies"
      expect(page).to have_selector("table tr", count: 20)
    end
  end
end
