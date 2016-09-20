class Listing < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable

  scope :price_range, ->(min, max) { where(price: min..max)}
  scope :min_price, ->(min) { where('price >= ?', min)}
  scope :max_price, ->(max) { where('price <= ?', max)}

  validates :title, :description, :price, presence: true
  validates :description, :length => { minimum: 10 }

  def self.filter(con)
  	self.where(con)
  end


end
