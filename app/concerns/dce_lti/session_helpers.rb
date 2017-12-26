module DceLti
  module SessionHelpers
    def valid_lti_request?(request)
      puts 'Valid 0'
      tp_valid = tool_provider.valid_request!(request)
      puts "Valid 1 #{tp_valid}"
      nonce_valid = Nonce.valid?(tool_provider.oauth_nonce)
      puts "Valid 2 #{nonce_valid}"
      timestamp_valid = TimestampValidator.valid?(tool_provider.oauth_timestamp)
      puts "Valid 3 #{timestamp_valid}"
      tp_valid && nonce_valid && timestamp_valid
    end

    def launch_params
      params.reject{ |k,v| ['controller','action'].include? k }
    end

    def consumer_key
      find_from_config(:consumer_key)
    end

    def consumer_secret
      find_from_config(:consumer_secret)
    end

    def find_from_config(attribute)
      lti_course.send(attribute)
    end

    def redirect_after_successful_auth
      Engine.config.redirect_after_successful_auth.call(self)
    end

    def lti_course
      return @lti_course if defined? @lti_course
      @lti_course = Course.find_by(
        consumer_key: launch_params[:oauth_consumer_key]
      )
      # TODO: Error if no course?
    end

    def tool_provider
      puts 'Getting tool provider'
      puts 'key'
      puts consumer_key
      puts 'secret'
      puts consumer_secret
      puts 'params'
      puts launch_params

      @tool_provider ||= IMS::LTI::ToolProvider.new(
        consumer_key, consumer_secret, launch_params
      )
    end

    def captured_attributes_from(tool_provider)
      Engine.config.copy_launch_attributes_to_session.inject({}) do |attributes, att|
        attributes.merge(att => tool_provider.send(att))
      end
    end
  end
end
