class ChangePlugTypeInPlugs < ActiveRecord::Migration[6.0]
  def change
    change_column :plugs, :plug_type, :integer, using: "plug_type::integer"
  end
end
