class CreateJobListings < ActiveRecord::Migration[5.2]
  def change
    create_table :job_listings do |t|
      t.string :title, null: false
      t.integer :platform, null: false, default: 0, index: true
      t.boolean :allow_remote, null: false, default: false, index: true
      t.string :location, null: false
      t.text :description, null: false
      t.string :slug, null: false, index: true
      t.string :company, null: false
      t.string :contact_email, null: false
      t.string :contact_name, null: false
      t.date :publish_date
      t.date :expiration_date, index: true
      t.boolean :is_published, null: false, default: false
      t.timestamps
    end
  end
end
