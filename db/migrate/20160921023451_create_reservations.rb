class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :listing, index: true, foreign_key: true
      t.date :begin_date
      t.date :end_date
      t.integer :guest_count

      t.timestamps null: false
    end
  end
end
