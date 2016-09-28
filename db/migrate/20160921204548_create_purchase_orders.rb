class CreatePurchaseOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :purchase_orders do |t|
      t.references :store, foreign_key: true
      t.string :name, :null => false, :unique => true

      t.timestamps
    end

    add_index :purchase_orders, :name
  end
end
