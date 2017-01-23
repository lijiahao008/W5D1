# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    FactoryGirl.build(:user,
      username: 'qweqwe',
      password: 'qweqwe'
    )
  end

  describe "model validation" do
    it "validates the password length of at least 6" do
      should validate_length_of(:password).is_at_least(6)
    end

    it "validates the presence of username" do
      should validate_presence_of(:username)
    end

    it "validates the presence of password_digest" do
      should validate_presence_of(:password_digest)
    end

    it "validates the presence of session_token" do
      should validate_presence_of(:session_token)
    end
  end

  describe "after initialization" do
    it "creates a password digest when a password is given" do
      expect(user.password_digest).to_not be_nil
    end

    it "creates a session token before validation" do
      user.valid? #??????
      expect(user.session_token).to_not be_nil
    end
  end

  describe "model association" do
    it "should have many goals" do
      should have_many(:goals)
    end

    it "should have many comments" do
      should have_many(:comments)
    end
  end

  describe "find_by_credentials" do
    before { user.save! }
    it "returns user if it's found" do
      expect(User.find_by_credentials("qweqwe", "qweqwe")).to eq(user)
    end

    it "returns nil if not found" do
      expect(User.find_by_credentials("pweqwe", "qweqwe")).to be_nil
    end
  end

  describe "doesn't store password in the database" do
    before { user.save! }
    it "does not return the password" do
      expect(User.find_by_credentials("qweqwe", "qweqwe").password).not_to be("qweqwe")
    end
  end


end
