class ChangePlugCostToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :plugs, :fixed_cost_per_15_min, :float
  end
end
