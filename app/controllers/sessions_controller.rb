class SessionsController < ApplicationController
  def create
    if user = RSpotify::User.new(request.env['omniauth.auth'])
      session[:user_id] = user.id
    end
    redirect_to current_user
  end

end
