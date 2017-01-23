# require 'rails_helper'
#
# RSpec.feature "Goals", type: :feature do
#   subject(:goal) do
#     FactoryGirl.build(:goal,
#       title: 'pass assessment04',
#       details: 'do or die',
#       user_id: '1' )
#   end
#
#
#
#   #new
#   describe "GET #new" do
#     it "render the new goal form" do
#       get :new
#       expect(response).to render_template("new")
#     end
#   end
#   #create
#   describe "POST #create" do
#     context "create goal with valid params" do
#       before :each do
#         post :create, params: { goal: { title: "whatever", details: "we are not gonna make it", user_id: 1 } }
#       end
#
#       it "creates a goal" do
#         goal = Goal.find_by(title: "whatever")
#         expect(goal.title).to eq("whatever")
#       end
#
#       it "redirects to goal's url" do
#         goal = Goal.find_by(title: "whatever")
#         expect(response).to redirect_to(goal_url(goal))
#       end
#     end
#
#     context "does not create with invalid goal params" do
#       it "re-render the new goal form" do
#         post :create, params: { goal: { title: "", details: "we are not gonna make it", user_id: 1 } }
#         expect(response).to render_template("new")
#         expect(flash[:errors]).to be_present
#       end
#
#       it "has pre_filled information" do
#         post :create, params: { goal: { title: "", details: "we are not gonna make it", user_id: 1 } }
#         expect(page).to have_content("we are not gonna make it")
#       end
#     end
#   end
#   #index
#   describe "GET #index" do
#     before :each do
#       post :create, params: { goal: { title: "whatever", details: "we are not gonna make it", user_id: 1 } }
#       post :create, params: { goal: { title: "whatever2", details: "we are not gonna make it2", user_id: 2 } }
#       goal1 = Goal.first
#       goal2 = Goal.last
#       get :index
#     end
#
#     it "render all goals page" do
#
#       expect(current_url).to eq(goals_url)
#     end
#
#     it "render all goals" do
#       expect(page).to have_content("whatever")
#       expect(page).to have_content("whatever2")
#     end
#
#     it "has a delete button" do
#       expect(page).to have_button("Remove whatever")
#       expect(page).to have_button("Remove whatever2")
#     end
#
#     it "has a link to the show page" do
#       expect(page).to have_link("whatever", :href=>goal_url(goal1))
#       expect(page).to have_link("whatever2", :href=>goal_url(goal2))
#     end
#
#     it "has a link to the new goal" do
#       expect(page).to have_link("New Goal", :href=>new_goal_url)
#     end
#
#   end
#   #show
#   describe "GET #index" do
#     before :each do
#       post :create, params: { goal: { title: "whatever", details: "we are not gonna make it", user_id: 1 } }
#       post :create, params: { goal: { title: "whatever2", details: "we are not gonna make it2", user_id: 2 } }
#       goal1 = Goal.first
#       goal2 = Goal.last
#
#     end
#
#     it "render all goals page" do
#
#       expect(current_url).to eq(goals_url)
#     end
#
#   end
#   #edit
#   #update
#   #destroy
# end
