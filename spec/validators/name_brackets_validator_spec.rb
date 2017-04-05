require "rails_helper"

describe NameBracketsValidator do
  subject { Validatable.new(name: name) }

  before { skip "To be implemented. Remove skip while implementing this task." }

  shared_examples "has valid name" do
    it "should be valid" do
      expect(subject).to be_valid
    end
  end

  shared_examples "has invalid name" do
    it "should not be valid" do
      expect(subject).not_to be_valid
    end
  end

  context "with curly brackets" do
    let(:name) { "The Fellowship of the Ring {Peter Jackson}" }
    it_behaves_like "has valid name"
  end

  context "with square brackets" do
    let(:name) { "The Fellowship of the Ring [Lord of The Rings]" }
    it_behaves_like "has valid name"
  end

  context "with not closed brackets" do
    let(:name) { "The Fellowship of the Ring (2001" }
    it_behaves_like "has invalid name"
  end

  context "with not opened brackets" do
    let(:name) { "The Fellowship of the Ring 2001)" }
    it_behaves_like "has invalid name"
  end

  context "with not too much closing brackets" do
    let(:name) { "The Fellowship of the Ring (2001) - 2003)" }
    it_behaves_like "has invalid name"
  end

  context "with not too much opening brackets" do
    let(:name) { "The Fellowship of the Ring (2001 - (2003)" }
    it_behaves_like "has invalid name"
  end

  context "with empty brackets" do
    let(:name) { "The Fellowship of the Ring ()" }
    it_behaves_like "has invalid name"
  end

  context "with matching brackets" do
    let(:name) { "The Fellowship of the Ring (2001)" }
    it_behaves_like "has valid name"
  end

  context "with multiple matching brackets" do
    let(:name) { "The Fellowship of the Ring [Lord of The Rings] (2001) {Peter Jackson}" }
    it_behaves_like "has valid name"
  end

  context "with nested matching brackets" do
    let(:name) { "The Fellowship of the Ring [Lord of The Rings {Peter Jackson}] (2012)" }
    it_behaves_like "has valid name"
  end

  context "with no brackets" do
    let(:name) { "Lord of The Rings" }
    it_behaves_like "has valid name"
  end
end

class Validatable
  include ActiveModel::Validations
  validates_with NameBracketsValidator
  attr_accessor :name

  def initialize(name:)
    @name = name
  end
end
