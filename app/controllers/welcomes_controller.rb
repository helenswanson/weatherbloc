class WelcomesController < ApplicationController
  def index
    if signed_in?
      redirect_to events_path
    end
  end
end
