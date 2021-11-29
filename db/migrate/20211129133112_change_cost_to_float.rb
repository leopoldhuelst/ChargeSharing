class ChangeCostToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :bookings, :cost, :float
  end
end
