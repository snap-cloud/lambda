class SessionsController < ApplicationController
  # Based heavily on: http://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/

  def create
    auth_hash = request.env['omniauth.auth']

    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
    rescue Exception => e
      puts e.message
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = "See you!"
    end
    redirect_to root_path
  end

  def auth_failure
    redirect_to root_path
  end
end
