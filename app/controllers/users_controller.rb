class UsersController < ApplicationController
  def show
  end

  def current
    render json: current_user
  end
end
