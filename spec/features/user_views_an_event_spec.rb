require 'rails_helper'

feature 'user views a new event', %Q(
  As an authenticated user
  I want to view an event
  So that I can see the event information
) do

# Acceptance Criteria:
# - Host is the only user who can edit event
# - Attendee of event with >= 3 attendees is the only user who can see event location
# - RSVP'd users see 'Withdraw RSVP' button and not 'RSVP' button
# - Non RSVP'd users see 'RSVP' button and not 'Withdraw RSVP' button
# - TODO If event is full, it cannot be joined.
# - TODO If an event is over, it cannot be joined.

  context 'authenticated user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login(@user)
    end

    scenario 'host views event page' do
      @event = FactoryGirl.create(:event, host: @user)
      visit event_path(@event)

      expect(page).to have_link('Edit event')
      # expect(page).to_not have_content(@event.street_address)
      # expect(page).to_not have_content(@event.city)
      # expect(page).to_not have_content(@event.state)
      # expect(page).to_not have_content(@event.zip_code)

      expect(page).to have_content(@event.title)
      # expect(page).to have_content(@event.categories)
      expect(page).to have_content(@event.description)
      expect(page).to have_content(@event.available_seats)
      expect(page).to have_content(@event.start_time.hour)
      expect(page).to have_content(@event.start_time.min)
      expect(page).to have_content(@event.end_time.hour)
      expect(page).to have_content(@event.end_time.min)

      expect(page).to_not have_button('RSVP')
      expect(page).to_not have_button('Withdraw RSVP')
    end

  #   context 'authenticated non-host' do
  #     before :each do
  #       @user = FactoryGirl.create(:user)
  #       login(@user)
  #       @event = FactoryGirl.create(:event)
  #       visit event_path(@event)

  #       expect(page).to_not have_link('Edit event')
  #       expect(page).to have_content(@event.title)
  #       expect(page).to have_content(@event.categories)
  #       expect(page).to have_content(@event.description)
  #       expect(page).to have_content(@event.available_seats)
  #       expect(page).to have_content(@event.start_time.hour)
  #       expect(page).to have_content(@event.start_time.min)
  #       expect(page).to have_content(@event.end_time.hour)
  #       expect(page).to have_content(@event.end_time.min)
  #     end

  #     scenario 'attendee views page for event with >= 3 attendees' do
  #       expect(page).to have_content(@event.street_address)
  #       expect(page).to have_content(@event.city)
  #       expect(page).to have_content(@event.state)
  #       expect(page).to have_content(@event.zip_code)

  #       expect(page).to_not have_button('RSVP')
  #       expect(page).to have_button('Withdraw RSVP')
  #     end

  #     context 'users not associated with a >= 3 attendees event' do
  #       before :each do
  #         expect(page).to_not have_content(@event.street_address)
  #         expect(page).to_not have_content(@event.city)
  #         expect(page).to_not have_content(@event.state)
  #         expect(page).to_not have_content(@event.zip_code)
  #       end

  #       scenario 'attendeee views page for event' do
  #         expect(page).to_not have_button('RSVP')
  #         expect(page).to have_button('Withdraw RSVP')
  #       end

  #       scenario 'user without RSVP views event page' do
  #         expect(page).to have_button('RSVP')
  #         expect(page).to_not have_button('Withdraw RSVP')
  #       end
  #     end

  #   end
  end

  scenario 'unauthenticated user cannot see event details' do
    @event = FactoryGirl.create(:event)
    visit event_path(@event)

    expect(page).to have_content('You need to sign in')
  end
end
