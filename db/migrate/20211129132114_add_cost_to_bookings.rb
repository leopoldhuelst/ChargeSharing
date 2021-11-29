class AddCostToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :cost, :integer
  end
end
