class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.integer :status
      t.integer :duration
      t.datetime :date_time
      t.references :user, null: false, foreign_key: true
      t.references :plug, null: false, foreign_key: true

      t.timestamps
    end
  end
end
