require 'rails_helper'

feature 'user creates own RSVP to an event', %Q(
  As an authenticated user
  I want to RSVP to an event
  So that I can attend the event
) do

# Acceptance Criteria:
# - I need to be signed in to do this.
# - I cannot be the event’s host.
# - I cannot RSVP twice.
# - I need to see my name added to an attendee list on thse event’s page.
# - I need to see a success message if my RSVP is successful.
# - I need to see an error message if RSVP is unsuccessful.

  before :each do
    @user = FactoryGirl.create(:user)
    login(@user)
  end

  scenario 'authenticated non-host RSVPs' do
    @event = FactoryGirl.create(:event)
    visit event_path(@event)
    click_button 'RSVP'
    expect(page).to have_content("Success! You have RSVP'd.")
    expect(page).to_not have_content('Error')
    expect(page).to_not have_css('#rsvp-button')
    expect(page).to have_button('Withdraw RSVP')
  end

  scenario 'authenticated host cannot RSVP' do
    @event = FactoryGirl.create(:event, host: @user)
    visit event_path(@event)

    expect(page).to_not have_button('RSVP')
    expect(page).to_not have_button('Withdraw RSVP')
  end
end
