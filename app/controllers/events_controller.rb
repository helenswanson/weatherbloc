class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if current_user
      @user = current_user
      users = User.near([@user.latitude, @user.longitude], 0.25)
      user_ids = []
      users.each do |user|
        unless user.id.nil?
          user_ids << user.id
        end
      end
      @events = Event.where("host_id IN (?)", user_ids)
    else
      if params[:search].present?
        @events = Event.near(params[:search], 0.25)
      else
        @events = Event.all
      end
    end
  end

  def show
    @event = Event.find(params[:id])
    # @attendees = Attendee.where(event: @event)
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

  def edit
    @event = Event.find(params[:id])
    authorize_to_edit
  end

  def update
    @event = Event.find(params[:id])
    authorize_to_edit
    if @event.update(event_params)
      flash[:notice] = 'Success'
      redirect_to event_path(@event)
    else
      flash.now[:notice] = 'Error'
      render :edit
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :description,
      :available_seats, :start_time, :end_time)
  end

  def authorize_to_edit
    if current_user != @event.host
      flash[:notice] = 'You are not authorized to do that.'
    end
  end
end
