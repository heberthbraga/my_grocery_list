class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps null: false
    end
  end
end
