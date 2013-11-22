require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    it "should have the title 'Sign Up'" do
      visit signup_path
      expect(page).to have_title('Sign up')
    end
  end
  describe "User profile page" do
    it "should have a profile page" do
      user = FactoryGirl.create(:user)
      visit user_path(user)
      expect(page).to have_content(user.name)
      expect(page).to have_title(user.name)
    end

  end

    it "does not create a user with invalid data" do
      visit signup_path
      click_on "Create my account"
      expect(User.count).to eq(0)
    end

    it "can create an account" do
      visit signup_path
      fill_in "Name",         with: "Example User"
      fill_in "Email",        with: "user@example.com"
      fill_in "Password",     with: "foobar"
      fill_in "Confirmation", with: "foobar"
      expect(User.count).to eq(0)
      click_button "Create my account"
      expect(User.count).to eq(1)
    end

end
