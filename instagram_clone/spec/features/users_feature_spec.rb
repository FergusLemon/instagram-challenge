require 'rails_helper'

feature "User can sign in and out:" do

  let(:user) { build :user }
  let(:user2) { build :user }

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

  feature 'user must be logged in to add photos' do
  it "should not display the 'Add a photo' link" do
    visit('/')
    click_link 'Add a photo'
    expect(page).not_to have_button 'Publish photo'
  end
end

feature 'user can only delete a photo it added' do
  let!(:photo) { Photo.create(description: 'Winter 2015') }

  xit "cannot delete a photo it did not add" do
    sign_up(user)
    add_photo(photo)
    click_link 'Sign out'
    sign_up(user2)
    visit '/photos'
    click_link 'Delete Winter 2015'
    expect(page).to have_content("You cannot delete another user's photos")
  end
end

feature 'user can only edit a photo it added' do
  let!(:photo) { Photo.create(description: 'Winter 2015') }

  xit "cannot edit a photo it did not add" do
    sign_up(user)
    add_photo(photo)
    click_link 'Sign out'
    sign_up(user2)
    visit '/photos'
    click_link 'Edit Winter 2015'
    expect(page).to have_content("You cannot edit another user's photos")
  end
end

feature 'user can delete comments' do
  let!(:photo) { Photo.create(description: 'Winter 2015') }

  context "user can delete their own comments" do
    xit "can delete comments it wrote" do
      sign_up(user)
      click_link 'Comment on Winter 2015'
      fill_in "Thoughts", with: "Burrrrrrr"
      click_button 'Publish comment'
      click_link 'Delete comment'
      expect(page).not_to have_content 'Burrrrrrr'
      expect(page).to have_content 'Your comment has been successfully deleted'
    end
  end

  context "cannot delete other users' commentss" do
    xit "cannot delete a comment it did not add" do
      sign_up(user)
      click_link 'Comment on Winter 2015'
      fill_in "Thoughts", with: "Burrrrrrr"
      click_button 'Publish comment'
      click_link 'Sign out'
      sign_up(user2)
      visit '/photos'
      click_link 'Delete comment'
      expect(page).to have_content("You cannot delete another user's comments")
    end
  end
end

end
