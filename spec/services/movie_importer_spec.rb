require "rails_helper"

describe MovieImporter do
  let(:movie) { create(:movie) }
  let(:service) { MovieImporter.new(movie) }

  context "movie with not existing title" do

    it "returns empty array" do
      expect(service.call).to eq []
    end

  end

  context "movie with existing title" do
    let(:movie) { create(:movie, title: "Godfather") }
    let(:result) { service.call }

    it "returns not empty hash" do
      expect(result).to be_kind_of(Hash)
      expect(result).not_to be_empty
    end

    it "returns movie details" do
      expect(result.size).to eq 4
      expect(result).to have_key("plot")
      expect(result).to have_key("poster")
      expect(result).to have_key("rating")
      expect(result).to have_key("title")
    end
  end
end
