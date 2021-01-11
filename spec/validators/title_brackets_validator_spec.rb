require "rails_helper"

describe TitleBracketsValidator do
  subject { Validatable.new(title: title) }

  shared_examples "has valid title" do
    it "should be valid" do
      expect(subject).to be_valid
    end
  end

  shared_examples "has invalid title" do
    it "should not be valid" do
      expect(subject).not_to be_valid
    end
  end

  context "with curly brackets" do
    let(:title) { "The Fellowship of the Ring {Peter Jackson}" }
    it_behaves_like "has valid title"
  end

  context "with square brackets" do
    let(:title) { "The Fellowship of the Ring [Lord of The Rings]" }
    it_behaves_like "has valid title"
  end

  context "with not closed brackets" do
    let(:title) { "The Fellowship of the Ring (2001" }
    it_behaves_like "has invalid title"
  end

  context "with not opened brackets" do
    let(:title) { "The Fellowship of the Ring 2001)" }
    it_behaves_like "has invalid title"
  end

  context "with not too much closing brackets" do
    let(:title) { "The Fellowship of the Ring (2001) - 2003)" }
    it_behaves_like "has invalid title"
  end

  context "with not too much opening brackets" do
    let(:title) { "The Fellowship of the Ring (2001 - (2003)" }
    it_behaves_like "has invalid title"
  end

  context "with empty brackets" do
    let(:title) { "The Fellowship of the Ring ()" }
    it_behaves_like "has invalid title"
  end

  context "with brackets in wrong order" do
    let(:title) { "The Fellowship of the )Ring(" }
    it_behaves_like "has invalid title"
  end

  context "with matching brackets" do
    let(:title) { "The Fellowship of the Ring (2001)" }
    it_behaves_like "has valid title"
  end

  context "with multiple matching brackets" do
    let(:title) { "The Fellowship of the Ring [Lord of The Rings] (2001) {Peter Jackson}" }
    it_behaves_like "has valid title"
  end

  context "with nested matching brackets" do
    let(:title) { "The Fellowship of the Ring [Lord of The Rings {Peter Jackson}] (2012)" }
    it_behaves_like "has valid title"
  end

  context "with no brackets" do
    let(:title) { "Lord of The Rings" }
    it_behaves_like "has valid title"
  end
end

class Validatable
  include ActiveModel::Validations
  validates_with TitleBracketsValidator
  attr_accessor :title

  def initialize(title:)
    @title = title
  end
end
