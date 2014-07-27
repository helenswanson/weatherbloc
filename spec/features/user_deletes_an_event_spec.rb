require 'rails_helper'

feature 'user deletes an event', %Q(
  As a user
  I want to delete my event I created
  So that it isn’t available for others to attend
) do

# Acceptance Criteria:
# - I need to be the host of this event
# - I need to click a link on the edit page to delete this event
# - I need to be prompted to be sure I want to delete this event
# - I need to see a success message if deletion is successful.
# - I need to see an error message if deletion is unsuccessful.

  context 'authenticated user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login(@user)
    end

    scenario 'host deletes event' do
      event = FactoryGirl.create(:event, host: @user)
      visit edit_event_path(event.id)

      click_on 'Delete Event'

      expect(page).to have_content('Deleted')
    end

    scenario 'non-host cannot delete event' do
      event = FactoryGirl.create(:event)
      visit edit_event_path(event.id)

      expect(page).to_not have_content('Delete Event')
      expect(page).to have_content('You are not authorized')
    end
  end

  scenario 'unauthenticated user cannot delete event' do
    event = FactoryGirl.create(:event)
    visit event_path(event.id)

    expect(page).to_not have_content('Delete Event')
    expect(page).to have_content('You need to sign in or sign up before continuing')
  end
end
