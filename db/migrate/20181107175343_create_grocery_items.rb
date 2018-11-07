class CreateGroceryItems < ActiveRecord::Migration[5.2]
  def change
    create_table :grocery_items do |t|
      t.belongs_to :greocery_store, index: true
      t.belongs_to :item, index: true

      t.decimal :price, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
