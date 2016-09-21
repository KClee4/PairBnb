class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :reservations, dependent: :destroy
  acts_as_taggable
  mount_uploaders :listing_images, ListingImageUploader

  scope :price_range, ->(min, max) { where(price: min..max)}
  scope :min_price, ->(min) { where('price >= ?', min)}
  scope :max_price, ->(max) { where('price <= ?', max)}

  validates :title, :description, :price, presence: true
  validates :description, :length => { minimum: 10 }

  def self.filter(con)
  	self.where(con)
  end


end
