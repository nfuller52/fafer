class CreatePlatforms < ActiveRecord::Migration[5.2]
  def change
    create_table :platforms do |t|
      t.string :name, null: false
      t.string :slug, null: false, index: true
      t.timestamps
    end
  end
end
