FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password "password"
  end

	factory :listing do
		listing_images Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/listings/listing.jpg')))
	end
end
