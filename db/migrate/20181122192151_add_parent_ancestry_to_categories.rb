class AddParentAncestryToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :parent_id, :integer
    add_index :categories, :parent_id
  end
end
