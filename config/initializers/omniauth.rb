Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"],
    {
      name: "google",
      access_type: 'offline',
      scope: "email, profile, plus.me",
      prompt: "select_account",
      image_aspect_ratio: "square",
      image_size: 50
    }

 OmniAuth.config.on_failure = Proc.new do |env|
   SessionsController.action(:auth_failure).call(env)
 end
end

