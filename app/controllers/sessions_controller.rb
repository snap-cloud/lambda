class SessionsController < ApplicationController
  # Based heavily on: http://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/

  # include DceLti::SessionHelpers
  # TODO: LTI thing, refactor
  # skip_before_filter :create, :verify_authenticity_token, :authenticate_via_lti

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

  def create_lti_session
    session[:launch_params] = launch_params
    if valid_lti_request?(request)
      user = UserInitializer.find_from(tool_provider)
      session[:current_user_id] = user.id
      session.merge!(captured_attributes_from(tool_provider))
      redirect_to redirect_after_successful_auth
    else
      puts 'SESSION ERROR'
      render :invalid
    end
  end
end
