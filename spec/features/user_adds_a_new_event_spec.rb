require 'rails_helper'

feature 'user adds a new event', %Q(
  As an authenticated user
  I want to add an event
  So that others can attend my event
) do

# Acceptance Criteria:
# + I need to be signed in to do this.
# + I need to provide the title, description, available seats, start time, end time.
# + I need to choose at least one type from checkbox menu.
# + I need to choose a time after the current time.
# + I need to see a success message if my event creation is successful.
# + I need to see an error message if my event creation is unsuccessful.
# - TODO logic scenarios for time (same day only, end time after start time)

  context 'authenticated user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login(@user)
    end

    scenario 'provides valid and required information' do
      event = FactoryGirl.build(:event)
      category = FactoryGirl.create(:category)
      click_link 'Host a new event'

      fill_in 'Title', with: event.title
      check 'Movies'
      fill_in 'Description', with: event.description
      fill_in 'Available Seats', with: event.available_seats
      # select event.start_time.hour, from: 'event_start_time_4i'
      # select event.start_time.min, from: 'event_start_time_5i'
      # select event.end_time.hour, from: 'event_end_time_4i'
      # select 'event.end_time.min', from: 'event_end_time_5i'
      click_button 'Start hosting your event'

      expect(page).to have_content('Success! Your event is live.')
      expect(page).to have_content(event.title)
      expect(page).to have_content('Movies')
      expect(page).to have_content(event.description)
      expect(page).to have_content(event.available_seats)
      # expect(page).to have_content(event.start_time.hour)
      # expect(page).to have_content(event.start_time.min)
      # expect(page).to have_content(event.end_time.hour)
      # expect(page).to have_content(event.end_time.min)
    end

    scenario 'does not supply required information' do
      click_link 'Host a new event'
      click_button 'Start hosting your event'

      expect(page).to have_content("can't be blank")
      expect(page).to_not have_content('Your event is live')
    end
  end

  scenario 'unauthenticated user cannot add a new event' do
    visit new_event_path

    expect(page).to have_content('You need to sign in')
  end
end
