class CreateJobPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :job_posts do |t|
      t.string :title, null: false
      t.integer :allow_remote, null: false, default: false
      t.string :location, null: false
      t.string :description, null: false
      t.string :contact, null: false
      t.date :publish_on, null: false
      t.integer :company_id, null: false
      t.integer :category_id, null: false
      t.timestamps
    end
  end
end
