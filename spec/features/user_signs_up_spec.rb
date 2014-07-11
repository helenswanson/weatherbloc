require 'rails_helper'

feature 'user signs up', %Q(
  As an unauthenticated user
  I want to sign up
  So that I can start using WeatherBloc
) do

# Acceptance Criteria:
# + I must specify a valid email address.
# + I must specify a password, and confirm that password.
# + I need to provide first name, last name, street address, city, state, and zip code.
# + I need to have the option to add an about section.
# + I need to have the option to add a profile photo.
# + I need to see a success message if sign up is successful.
# + I need to see an error message if sign up is unsuccessful.
# - TODO I need to receive an email confirming my new account.
# - If I enter an existing email/password, I am authenticated and get signed in.
# + If I am signed in, I can't sign in again.

  before :each do
    @user = FactoryGirl.build(:user)
    visit root_path
    click_link 'Sign up'
  end

  context 'user submits a complete form' do
    before :each do
      fill_in 'First Name', with: @user.first_name
      fill_in 'Last Name', with: @user.last_name
      fill_in 'Email', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'Street Address', with: @user.street_address
      fill_in 'City', with: @user.city
      fill_in 'State', with: @user.state
      fill_in 'Zip Code', with: @user.zip_code
      fill_in 'About', with: @user.about
      attach_file 'Profile Photo', File.join(Rails.root, '/spec/support/example.jpg')
    end

    scenario 'user provides valid and required information' do
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Sign up'

      expect(page).to have_content('signed up successfully')
      expect(page).to have_content('Host a new event')
      expect(page).to have_content('Sign out')
      expect(page).to_not have_content('Sign up')
      expect(page).to_not have_content('Sign in')
    end

    scenario 'user password confirmation does not match password' do
      fill_in 'user[password_confirmation]', with: 'drowssap'
      click_button 'Sign up'

      expect(page).to have_content("doesn't match")
      expect(page).to_not have_content('Host a new event')
      expect(page).to_not have_content('Sign out')
      expect(page).to have_content('Sign up')
    end
  end

  scenario 'user does not supply required information' do
    click_button 'Sign up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Host a new event')
    expect(page).to_not have_content('Sign out')
    expect(page).to have_content('Sign up')
  end
end
