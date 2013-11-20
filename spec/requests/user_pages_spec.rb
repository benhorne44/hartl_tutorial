require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    it "should have the title 'Sign Up'" do
      visit signup_path
      expect(page).to have_title('Sign up')
    end
  end

end
