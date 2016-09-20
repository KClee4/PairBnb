class Listing < ActiveRecord::Base
  belongs_to :user

  scope :price_range, ->(min, max) { where(price: min..max)}

  validates :title, :description, :price, presence: true
  validates :description, :length => { minimum: 10 }

  def self.filter(con)
  	self.where(con)
  end


end
