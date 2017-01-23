require 'rails_helper'

RSpec.describe Goal, type: :model do


  describe "model validation" do
    it "validates the presence of title" do
      should validate_presence_of(:title)
    end

    it "validates the presence of details" do
      should validate_presence_of(:details)
    end

    it "validates the presence of user" do
      should validate_presence_of(:user)
    end
  end

  describe "model association" do
    it "should belong to a user" do
      should belong_to(:user)
    end
  end
end
