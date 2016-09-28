class Listing < ActiveRecord::Base
  searchkick match: :word_start, autocomplete: [:title]
  belongs_to :user
  has_many :reservations, dependent: :destroy
  acts_as_taggable
  mount_uploaders :listing_images, ListingImageUploader

  scope :price_range, ->(min, max) { where(price: min..max)}

  validates :title, :description, :price, :listing_images, presence: true
  validates :description, :length => { minimum: 10 }

  def self.filter(con)
  	self.where(con)
  end

  def self.filter_by_range(range = {})
    min = range.fetch(:min)
    max = range.fetch(:max)

    if min && max 
      return price_range(min, max)
    end
  end

  def search_data
    attributes.merge(
      tags_name: tags.map(&:name)
    )
  end
end
