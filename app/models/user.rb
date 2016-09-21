class User < ActiveRecord::Base
  
  include Clearance::User
  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy
  has_many :reservations, :dependent => :destroy

  mount_uploader :profile_image, ProfileImageUploader


  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.firstname = auth_hash["info"]["first_name"]
      u.lastname = auth_hash["info"]["last_name"]
      u.birthday = auth_hash["extra"]["raw_info"]["birthday"] ? Date.parse(auth_hash["extra"]["raw_info"]["birthday"].gsub(/(\d{2})\/(\d{2})\/(\d{4})/,"#{$3}-#{$1}-#{$2}")) : nil
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.password = SecureRandom.base64(10)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

  
end

