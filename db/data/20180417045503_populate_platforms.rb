class PopulatePlatforms < ActiveRecord::Migration[5.2]
  def up
    platforms.each do |platform_name|
      Platform.create!(name: platform_name)
    end
  end

  def down
    Platform.where(name: platforms).destroy_all
  end

  def platforms
    %w(NetSuite Oracle SAP)
  end
end
