class AddCoordinatesToPlugs < ActiveRecord::Migration[6.0]
  def change
    add_column :plugs, :latitude, :float
    add_column :plugs, :longitude, :float
  end
end
