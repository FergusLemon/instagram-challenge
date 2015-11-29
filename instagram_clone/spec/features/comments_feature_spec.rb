require 'rails_helper'

feature 'Leaving comments on photos:' do
  let!(:photo) { Photo.create(description: 'Winter holiday') }

  scenario 'users can comment on photos' do
    visit '/'
    click_link 'Comment on Winter holiday'
    fill_in 'Thoughts', with: 'Looks cold'
    click_button 'Publish comment'
    expect(current_path).to eq '/photos'
    expect(page).to have_content 'Looks cold'
  end

end
