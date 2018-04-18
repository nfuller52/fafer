class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price_in_cents, null: false
      t.string :feature_flag
      t.timestamps
    end
  end
end
