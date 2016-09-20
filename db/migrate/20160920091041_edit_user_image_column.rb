class EditUserImageColumn < ActiveRecord::Migration
  def change
  	change_column :users, :profile_image, :string
  end
end
