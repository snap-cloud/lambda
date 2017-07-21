module DceLti
  module SessionHelpers
    def valid_lti_request?(request)
      tp_valid = tool_provider.valid_request?(request)
      puts "Tool Provider Valid? #{tp_valid}"
      nonce_valid = Nonce.valid?(tool_provider.oauth_nonce)
      puts "Nonce Valid? #{nonce_valid}"
      timestamp_valid = TimestampValidator.valid?(tool_provider.oauth_timestamp)
      puts "Timestamp Valid? #{timestamp_valid}"
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
      value = Engine.config.send(attribute)
      if value.respond_to?(:call)
        value.call(launch_params)
      else
        value
      end
    end

    def redirect_after_successful_auth
      Engine.config.redirect_after_successful_auth.call(self)
    end

    def tool_provider
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
