module DceLti
  class SessionsController < ApplicationController
    include SessionHelpers

    skip_before_filter :create, :verify_authenticity_token
    skip_before_filter :verify_authenticity_token, :authenticate_via_lti

    def create
      puts "Create 0"
      puts "LAUNCH PARAMS"
      session[:launch_params] = launch_params
      puts launch_params
      puts "PARAMS KEYS"
      puts params.keys
      puts "LAUNCH PARAMS KEYS"
      puts launch_params.keys
      puts "Session"
      if valid_lti_request?(request)
        puts "Valid true"
        user = UserInitializer.find_from(tool_provider)
        session[:current_user_id] = user.id
        session.merge!(captured_attributes_from(tool_provider))
        redirect_to redirect_after_successful_auth
      else
        puts 'Not valid'
        @errors = []
        if current_user&.admin?
          @errors << "Consumer Key: #{consumer_key}"
          @errors << "Consumer Secret: #{consumer_secret}"
        end
        render 'sessions/invalid'
      end
    end
  end
end
