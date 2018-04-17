class AddPlatformReferenceToJobListings < ActiveRecord::Migration[5.2]
  def change
    add_reference :job_listings, :platform, foreign_key: true
  end
end
