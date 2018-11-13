class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.belongs_to :role
      t.string :first_name
      t.string :last_name
      t.string :email,              index: true
      t.string :password_digest,    null: false
      t.boolean :active,            default: true

      t.timestamps null: false
    end
  end
end
