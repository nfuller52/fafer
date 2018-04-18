class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0, index: true
      t.references :job_listing, foreign_key: true
      t.integer :total_in_cents, default: 0
      t.string :customer_email
      t.timestamps
    end
  end
end
