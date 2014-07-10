require 'rails_helper'

feature 'user signs up', %Q(
  As an unauthenticated user
  I want to sign up
  So that I can start using WeatherBloc
) do

# Acceptance Criteria:
# - I must specify a valid email address.
# - I must specify a password, and confirm that password.
# - ---- other devise related stuff
# - I need to provide first name, last name, street address, city, state, and zip code.
# - I need to have the option to add an about section.
# - TODO I need to have the option to add a profile photo.
# - I need to see a success message if sign up is successful.
# - I need to see an error message if sign up is unsuccessful.
# - TODO I need to receive an email confirming my new account.
# - If I enter an existing email/password, I am authenticated and get signed in.
# - If I am signed in, I can't sign in again.

  scenario 'user specifies valid and required information' do

    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'

    fill_in 'Street Address', with: '1234 Main Street'
    fill_in 'City', with: 'Cambridge'
    fill_in 'Zip Code', with: '02139'
    fill_in 'About', with: 'I am nice.'
    # fill_in 'Profile Photo', with:

    expect(page).to have_content("You're in!")
    expect(page).to have_content('Sign Out')

  end

  scenario 'user password confirmation does not match password'

  scenario 'user does not supply required information'

  scenario 'user signs up with profile photo'

end
