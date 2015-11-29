require 'rails_helper'

feature "photos" do
  let(:user) { build :user }
  let(:user2) { build :user }

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
      click_button 'Publish photo'
      expect(current_path).to eq '/photos'
      expect(page).to have_content 'Summer holiday'
    end
  end

  context "viewing photos" do
    let!(:photo) { Photo.create(description: 'Winter holiday') }

    scenario "a user can view an individual photo" do
      visit '/'
      click_link 'Winter holiday'
      expect(current_path).to eq "/photos/#{photo.id}"
      expect(page).to have_content 'Winter holiday'
    end
  end

  context "editing photos" do
    let!(:photo) { Photo.create(description: 'Winter holiday') }

    scenario "a user can edit a photo" do
      visit '/'
      click_link 'Edit Winter holiday'
      fill_in 'Description', with: 'Winter 2015'
      click_button 'Update photo'
      expect(current_path).to eq '/photos'
      expect(page).to have_content 'Winter 2015'
    end
  end

  context "deleting photos" do
    let!(:photo) { Photo.create(description: 'Winter holiday') }

    scenario "a user can delete a photo" do
      visit '/'
      click_link 'Delete Winter holiday'
      expect(current_path).to eq '/photos'
      expect(page).not_to have_content 'Winter holiday'
    end
  end

end
