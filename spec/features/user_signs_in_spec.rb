require 'rails_helper'

feature 'user signs in', %Q(
As an authenticated user
I want to sign in
So that I can access extra features
) do

# Acceptance Criteria:
# - I need to provide correct email and password.
# - I need to click a link to sign in.
# - I need to see a success message if sign in is successful.
# - I need to see an error message if sign in is unsuccessful.

  before :each do
    @user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign in'
  end

  context 'user submits a complete form' do
    before :each do
      fill_in 'Email', with: @user.email
    end

    scenario 'user provides valid and required information' do
      fill_in 'Password', with: @user.password
      click_button 'Sign in'

      expect(page).to have_content('Signed in successfully')
      expect(page).to have_content('Sign out')
      expect(page).to_not have_content('Sign in')
    end


    scenario 'user email and password do match password' do
      fill_in 'Password', with: 'drowssap'
      click_button 'Sign in'

      expect(page).to have_content("Invalid email or password")
      expect(page).to_not have_content('Sign out')
      expect(page).to have_content('Sign in')
    end
  end

  scenario 'user does not supply required information' do
    click_button 'Sign in'

    expect(page).to have_content("Invalid email or password")
    expect(page).to_not have_content('Sign out')
    expect(page).to have_content('Sign in')
  end
end
