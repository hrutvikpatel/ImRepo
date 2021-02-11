require 'rails_helper'

RSpec.describe Category, :type => :model do
  context "is valid" do
    it "with valid attributes" do
      category = create(:category)
      expect(category).to be_valid
    end
  end

  context "is not valid" do
    it "without a name" do
      expect(Category.new).to_not be_valid
    end
  end
end