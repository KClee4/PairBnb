class AddProfileImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_image, :json
  end
end
