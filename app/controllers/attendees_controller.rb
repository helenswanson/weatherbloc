class AttendeesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @attendee = Attendee.new(user: current_user, event: @event)

    if @attendee.save
      flash[:notice] = "Success! You have RSVP'd."
      redirect_to event_path(@event)
    else
      flash[:notice] = "Error"
      render "event/show"
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @attendee = Attendee.where(event: @event).first

    if @attendee.destroy
      flash[:notice] = "Success! You have withdrawn your RSVP'd."
      redirect_to event_path(@event)
    else
      flash[:notice] = "Error"
      render "event/show"
    end
  end

  private
  def user_params
  end
end
