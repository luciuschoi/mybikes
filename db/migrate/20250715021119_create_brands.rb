class CreateBrands < ActiveRecord::Migration[8.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :logo
      t.text :description
      t.integer :founded_year
      t.string :country
      t.string :category
      t.string :website

      t.timestamps
    end
  end
end
