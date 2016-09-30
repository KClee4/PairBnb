class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  def retrieve!(_identifier)
    true
  end
end

CarrierWave.configure do |config|
	if Rails.env.test? || Rails.env.cucumber?
		config.storage NullStorage
	  config.enable_processing = false
	else
	  config.fog_credentials = {
	    :provider => 'AWS',
	    :aws_access_key_id => ENV["AMAZON_ACCESS_KEY"],
	    :aws_secret_access_key => ENV["AMAZON_SECRET_KEY"],
	    :region => 'ap-southeast-1'
	  }
	  config.fog_directory  = "pairbnb47"
end  
  