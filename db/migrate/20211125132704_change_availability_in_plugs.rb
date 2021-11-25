class ChangeAvailabilityInPlugs < ActiveRecord::Migration[6.0]
  def change
    remove_column :plugs, :availability
    add_column :plugs, :availability, :integer
  end
end
