class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, :null => false, :unique => true
      t.string :password_hash, :null => false
      t.string :password_salt, :null => false
      t.integer :role, :null => false

      t.timestamps
    end

    # Since users are primarily queried by this parameter, an index is preferable.
    add_index :users, :name
  end
end
