class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :picture
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
