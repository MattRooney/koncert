class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      session[:auth_info] = request.env['omniauth.auth']
    end
    redirect_to user_path(user)
  end

  def destroy
    session.clear
    redirect_to "/"
  end
end
