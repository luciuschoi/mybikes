class CreateModels < ActiveRecord::Migration[8.0]
  def change
    create_table :models do |t|
      t.string :name
      t.references :brand, null: false, foreign_key: true
      t.integer :year
      t.string :category
      t.decimal :price
      t.integer :engine_displacement
      t.decimal :weight
      t.string :fuel_type
      t.string :transmission
      t.text :colors
      t.json :specifications

      t.timestamps
    end
  end
end
