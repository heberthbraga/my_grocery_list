class AddQuantityToExistingItems < ActiveRecord::Migration[5.2]
  def up
    Item.all.each do |item|
      item.update_column(:quantity, 1)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
