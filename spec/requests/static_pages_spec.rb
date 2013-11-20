require 'spec_helper'

describe "Static pages" do

  describe "Layout" do
    it "should have functioning links" do
      visit root_path
      click_link "Home"
      expect(page).to have_title('Sample App')
      click_link "About"
      expect(page).to have_title('About')
      click_link "Help"
      expect(page).to have_title('Help')
      click_link "Contact"
      expect(page).to have_title('Contact')
      click_link "Home"
      click_link "Sign up now!"
      expect(page).to have_title('Sign up')
    end
  end

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit root_path
      expect(page).to have_title('Sample App')
    end

  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_title('Help')
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit about_path
      expect(page).to have_title('About Us')
    end
  end

  describe "Contact page" do

    it "should have the title 'Contact" do
      visit contact_path
      expect(page).to have_title('Contact')
    end
  end

end
