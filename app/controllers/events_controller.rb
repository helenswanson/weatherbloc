class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.host = current_user

    if @event.save
      params[:event][:category_ids].each do |category_id|
        if category_id != ""
          category = Category.find(category_id)
          Categorization.create(event: @event, category: category)
        end
      end
      flash[:notice] = 'Success! Your event is live.'
      redirect_to @event
    else
      flash.now[:notice] = 'Error. Please try again.'
      render :new
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :description,
      :available_seats, :start_time, :end_time)
  end
end
