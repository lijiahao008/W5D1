require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:user) { User.create!(username: 'jack_bruce', password: 'abcdef') }

  subject(:goal1) do
    FactoryGirl.create(:goal,
      title: 'whatever',
      details: 'do or die',
      user_id: user.id )
  end

  subject(:goal2) do
    FactoryGirl.create(:goal,
      title: 'whatever2',
      details: 'die',
      user_id: user.id )
  end

  describe "GET #new" do
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end
      it "render the new goal form" do
        get :new
        expect(response).to render_template("new")
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end
      it "redirect_to the sign in form" do
        get :new
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "POST #create" do
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end
      context "create goal with valid params" do
        before :each do
          post :create, params: { goal: { title: "whatever", details: "we are not gonna make it", user_id: 1 } }
        end

        it "creates a goal" do
          goal = Goal.find_by(title: "whatever")
          expect(goal.title).to eq("whatever")
        end

        it "redirects to goal's url" do
          goal = Goal.find_by(title: "whatever")
          expect(response).to redirect_to(goal_url(goal))
        end
      end

      context "does not create with invalid goal params" do
        it "re-render the new goal form" do
          post :create, params: { goal: { title: "", details: "we are not gonna make it", user_id: 1 } }
          expect(response).to render_template("new")
          expect(flash[:errors]).to be_present
        end
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end
      it "redirect_to the sign in form" do
        post :create, params: { goal: { title: "", details: "we are not gonna make it", user_id: 1 } }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "GET #index" do
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end
      it "render all the goals" do
        get :index
        expect(response).to render_template("index")
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end
      it "redirect_to the sign in form" do
        get :index
        expect(response).to redirect_to(new_session_url)
      end
    end

  end

  describe "GET #show" do
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end

      before :each do
        post :create, params: { goal: { title: "whatever", details: "we are not gonna make it", user_id: 1 } }
        post :create, params: { goal: { title: "whatever2", details: "we are not gonna make it2", user_id: 2 } }
        goal1 = Goal.first
        goal2 = Goal.last
      end

      it "render the goal page" do
        # debugger
        get :show, params: { id: goal1.id }
        expect(response).to render_template("show")
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirect_to the sign in form" do
        get :show, params: { id: goal1.id }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "GET #edit" do
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end

      before :each do
        post :create, params: { goal: { title: "whatever", details: "we are not gonna make it", user_id: 1 } }
        post :create, params: { goal: { title: "whatever2", details: "we are not gonna make it2", user_id: 2 } }
        goal1 = Goal.first
        goal2 = Goal.last
      end

      it "render the edit page" do
        get :edit, params: { id: goal1.id }
        expect(response).to render_template("edit")
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirect_to the sign in form" do
        get :edit, params: { id: goal1.id }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "PATCH #update" do
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end

      it "successfully updates the attribute" do
        patch :update, params: { id: goal1.id, goal: { title: "whatever?" } }
        new_goal = Goal.find(goal1.id)
        expect(new_goal.title).to eq('whatever?')
      end

      it "render the goal page after successful update" do
        patch :update, params: { id: goal1.id, goal: { title: "whatever?" } }
        expect(response).to redirect_to(goal_url(goal1))
      end

      it "re-renders the edit form when the update fails" do
        patch :update, params: { id: goal1.id, goal: { title: "" } }
        expect(response).to render_template('edit')
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirect_to the sign in form" do
        patch :update, params: { id: goal1.id, goal: { title: "" } }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end

      it "successfully deletes the goal" do
        delete :destroy, params: { id: goal1.id }
        goal = Goal.find_by(title: "whatever")
        expect(goal).to be_nil
      end

      it "redirect to index page after successful delete" do
        delete :destroy, params: { id: goal1.id }
        expect(response).to redirect_to(goals_url)
      end

      it "raise error when the destroy fails" do
        expect do
          delete :destroy, params: { id: 1 }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirect_to the sign in form" do
        delete :destroy, params: { id: goal1.id }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end
end
