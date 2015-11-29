module Helpers

  def sign_up(user)
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
  end

  def add_photo(description)
    visit '/'
    click_link 'Add a photo'
    fill_in 'Description', with: description
    click_button 'Publish photo'
  end

end
