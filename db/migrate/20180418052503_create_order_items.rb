class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :item, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :price_in_cents, null: false
      t.integer :quantity, default: 1, null: false
      t.timestamps
    end
  end
end
