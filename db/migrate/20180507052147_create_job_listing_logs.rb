class CreateJobListingLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :job_listing_logs do |t|
      t.references :job_listing
      t.string :job_listing_status, null: false
      t.string :event, null: false, index: true
      t.datetime :time_stamp
      t.jsonb :data_before
      t.jsonb :data_after

      t.timestamps
    end
  end
end
