require 'spec_helper'

describe "Authentication" do

  describe "signin page" do
    before { visit signin_path }

    it "should have the title sign in" do
      expect(page).to have_title('Sign in')
    end

    describe "invalid information" do

      it "with invalid signin" do
        fill_in "Email", with: "mike@example.com"
        fill_in "Password", with: "foobar"
        within('#sign-in-button') do
          click_on "Sign in"
        end
        expect(page).to have_selector('div.alert.alert-error', text: 'Invalid')
      end
    end


    describe "valid information" do

      it "with valid signin" do
        user = FactoryGirl.create(:user)
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        within('#sign-in-button') do
          click_on "Sign in"
        end
        expect(page).to have_title(user.name)
        expect(page).to have_link('Profile', href: user_path(user))
        expect(page).to have_link('Sign out', href: signout_path)
        expect(page).to_not have_link('Sign in', href: signin_path)
      end
    end

  end

end
