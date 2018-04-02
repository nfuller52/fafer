class CreateJobListings < ActiveRecord::Migration[5.1]
  def change
    create_table :job_listings do |t|
      t.string :title, null: false
      t.integer :platform, null: false, default: 0, index: true
      t.boolean :allow_remote, null: false, default: false, index: true
      t.string :location, null: false
      t.text :description, null: false
      t.string :slug, null: false, index: true
      t.string :company, null: false, index: true
      t.string :contact, null: false
      t.datetime :publish_at, null: false, default: Time.now
      t.timestamps
    end
  end
end
