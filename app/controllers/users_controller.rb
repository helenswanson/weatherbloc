class UsersController < ApplicationController
  def index
    redirect_to events_path
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def user_params
  end
end
