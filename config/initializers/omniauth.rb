Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["APP_ID"], ENV["APP_SECRET"],
  	info_fields: 'first_name, last_name, email, birthday', :provider_ignores_state => true
end 
OmniAuth.config.on_failure = Proc.new { |env|
 Rack::Response.new(['302 Moved'], 302, 'Location' => "/").finish
}