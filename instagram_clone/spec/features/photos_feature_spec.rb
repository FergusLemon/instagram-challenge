require 'rails_helper'

feature "photos" do
  context "no photos have been added" do
    scenario "should display a prompt to add a photo" do
      visit '/photos'
      expect(page).to have_content 'No photos have been added yet'
      expect(page).to have_link "Add a photo"
    end
  end

  before do
    sign_up(user)
  end

  context "creating photos" do
    scenario "prompts user to fill in a form and then displays photos" do
      visit '/'
      click_link 'Add a photo'
      fill_in 'Description', with: 'Summer holiday'
      click_button 'Upload photo'
      expect(current_path).to eq '/photos'
      expect(page).to have_content 'Summer holiday'
    end
  end
end
