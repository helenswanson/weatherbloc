require 'rails_helper'

feature 'user signs out', %Q(
As an authenticated user
I want to sign out
So that I can protect my personal information
) do

# Acceptance Criteria:
# + I need to be signed in.
# + I need to see a success message if sign out is successful.
# + I need to see an error message if sign out is unsuccessful.
# + If I am signed out, I can't sign out again.

  scenario 'user clicks sign out link' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign in'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    click_link 'Sign out'


    expect(page).to have_content('Signed out successfully')
    expect(page).to_not have_content('Host a new event')
    expect(page).to_not have_content('Sign out')
    expect(page).to have_content('Sign in')
    expect(page).to have_content('Sign up')
  end
end
