class RemovePlatformFromJobListings < ActiveRecord::Migration[5.2]
  def change
    remove_column :job_listings, :platform, :integer
  end
end
