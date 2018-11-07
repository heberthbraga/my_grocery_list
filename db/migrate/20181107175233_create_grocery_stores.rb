class CreateGroceryStores < ActiveRecord::Migration[5.2]
  def change
    create_table :grocery_stores do |t|
      t.string :name
      t.string :website
      t.string :fantasy_name
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
