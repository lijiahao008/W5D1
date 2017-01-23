require 'rails_helper'

RSpec.feature "Auths", type: :feature do


  feature "Sign Up" do
    before :each do
      visit new_user_url
    end

    scenario "accepts a username and password" do
      expect(page).to have_content("Username")
      expect(page).to have_content("Password")
    end

    scenario "display a sign up form" do
      expect(page).to have_content("Sign Up Form")
    end

    scenario "redirects to goals index when successful sign up" do
      fill_in('Username', with: 'username')
      fill_in('Password', with: 'password')
      click_button('Sign Up')
      expect(current_path).to eq(goals_path)
    end

    scenario "re-render the form when sign up fails" do
      fill_in('Username', with: '')
      fill_in('Password', with: '')
      click_button('Sign Up')
      expect(page).to have_content('Sign In')
      expect(page).to have_content('Sign Up')

    end

    scenario "displays errors when sign up fails" do
      fill_in('Username', with: '')
      fill_in('Password', with: '')
      click_button('Sign Up')
      expect(page).to have_content("Username can't be blank")
    end
  end

  feature "Sign In" do
    before :each do
      user = User.create(username: "username", password: "password")
      visit new_session_url
    end

    scenario "displays a sign in page" do
      expect(page).to have_content("Username")
      expect(page).to have_content("Password")
    end

    scenario "has a sign up and sign in links" do
      expect(page).to have_content('Sign In')
      expect(page).to have_content('Sign Up')
    end

    feature "Successful Sign In" do

      before :each do
        fill_in('Username', with: 'username')
        fill_in('Password', with: 'password')
        click_button('Sign In')
      end

      scenario "displays a sign out button" do
        expect(page).to have_button('Sign Out')
      end

      scenario "displays the current username" do
        expect(page).to have_content "username"
      end

      scenario "redirects to goals_url when sign in successful" do
        expect(current_path).to eq(goals_path)
      end
    end

    feature "Unsuccessful Sign In" do
      before :each do
        fill_in('Username', with: 'username')
        fill_in('Password', with: 'p')
        click_button('Sign In')
      end

      scenario "flash error message" do
        expect(page).to have_content("wrong")
      end

      scenario "re-render the sign in page" do
        expect(page).to have_content('Sign In')
        expect(page).to have_content('Sign Up')
      end
    end
  end
end
