class AddListingImageToListing < ActiveRecord::Migration
  def change
    add_column :listings, :listing_images, :json
  end
end
