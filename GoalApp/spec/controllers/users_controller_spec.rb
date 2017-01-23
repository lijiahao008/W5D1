require 'rails_helper'

begin
  UsersController
rescue
  UsersController = nil
end

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "render the sign up form" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "create user with valid params" do
      before :each do
        post :create, params: { user: { username: "qweqwe", password: "qweqwe" } }
      end

      it "login the user" do
        user = User.find_by(username: "qweqwe")
        expect(session[:session_token]).to eq(user.session_token)
      end

      it "redirects to goals url" do
        expect(response).to redirect_to(goals_url)
      end
    end

    context "does not create with invalid user params" do
      it "re-render the sign up form" do
        post :create, params: { user: { username: "qweqwe", password: "" } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end
  end
end
