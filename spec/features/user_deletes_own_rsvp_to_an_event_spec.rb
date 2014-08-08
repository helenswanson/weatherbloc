require 'rails_helper'

feature 'user deletes own RSVP to an event', %Q(
  As an authenticated user
  I want to be able to remove my rsvp for an event
  So that the host knows I am no longer attending
) do

# Acceptance Criteria:
# - I need to be signed in to do this.
# - I need to be an attendee to the event.
# - I cannot remove my RSVP if I have already done so.
# - I need to see a success message if my RSVP is successful.
# - I need to see an error message if RSVP is unsuccessful.

  scenario 'attendee removes own rsvp' do
    @user = FactoryGirl.create(:user)
    login(@user)
    @event = FactoryGirl.create(:event)
    visit event_path(@event)

    click_button 'RSVP'
    click_button 'Withdraw RSVP'

    expect(page).to have_css('#rsvp-button')
    expect(page).to_not have_button('Withdraw RSVP')
  end
end
