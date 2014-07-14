class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = 'Success! Your event is live.'
    else
      flash.now[:notice] = 'Error. Please try again.'
      render :new
    end
  end


  private
  def event_params
    params.require(:event).permit(:title, :category1, :category2, :category3,
      :description, :available_seats, :start_time, :end_time)
  end
end
