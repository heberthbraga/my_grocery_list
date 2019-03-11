class AddQuantityToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :quantity, :integer, after: :picture
  end
end
