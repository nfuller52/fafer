class AddItemIdToPlatforms < ActiveRecord::Migration[5.2]
  def change
    add_reference :platforms, :item, foreign_key: true
  end
end
