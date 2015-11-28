require 'rails_helper'

feature "User can sign in and out:" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit '/'
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Sign up'
    end

    it "should not see a 'sign out' link" do
      visit '/'
      expect(page).not_to have_link 'Sign out'
    end
  end

  context "user signed in and on the hompage" do
    before do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'password1'
      fill_in 'Password confirmation', with: 'password1'
      click_button 'Sign up'
    end

    it "should see the 'sign out' link" do
      visit '/'
      expect(page).to have_link 'Sign out'
    end

    it "should not see the 'sign in' or 'sign up' link" do
      visit '/'
      expect(page).not_to have_link 'Sign in'
      expect(page).not_to have_link 'Sign up'
    end
  end
end