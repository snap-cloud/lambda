class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Session helpers give usaccess to consumer_key and consumer_secret
  include DceLti::SessionHelpers

  # We store the original request parameters in the session for use later on.
  # This allows us to re-create a tool provider instance whenever we need.
  # The TP instance could be used from any controller
  # TODO: Store TP instance.
  def get_tool_provider
    @tool_provider ||= setup_tool_provider
  end

  private

  def setup_tool_provider
    launch_params = session[:launch_params]
    return unless launch_params
    course = Course.find_by(consumer_key: launch_params[:oauth_consumer_key])
    return unless course # TODO: render invalid, and display error.
    IMS::LTI::ToolProvider.new(
      course.consumer_key, course.consumer_secret, launch_params
    )
  end

  def require_admin
    return true if Rails.env.development?

    if !current_user || (current_user && !current_user.admin)
      flash[:error] = "Visiting '#{request.fullpath}' requires an administrator account"
      redirect_to '/' and return
    end
  end

  helper_method :require_admin

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user

end
