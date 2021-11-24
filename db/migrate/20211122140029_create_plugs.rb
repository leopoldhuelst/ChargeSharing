class CreatePlugs < ActiveRecord::Migration[6.0]
  def change
    create_table :plugs do |t|
      t.string :plug_type
      t.string :location
      t.datetime :availability
      t.text :description
      t.integer :fixed_cost_per_15_min
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
